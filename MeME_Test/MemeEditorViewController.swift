//
//  MemeEditorViewController.swift
//  MeME_Test
//
//  Created by GIUSEPPE SANTANIELLO on 30/06/15.
//  Copyright (c) 2015 GIUSEPPE SANTANIELLO. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: properties
    @IBOutlet weak var cameraButtonItem: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    var meme: Meme!
    var yFrameForTextFieldSelected: CGFloat = 0.0

    
    // -------------------------------------
    // MARK: Life Cycle views
    // -------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraButtonItem.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //Setup TextField Attribute
        let memeTextAttribute = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -3.0
        ]
        
        //Setup TextFields
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        self.topTextField.text = "TOP"
        self.bottomTextField.text = "BOTTOM"
        self.topTextField.defaultTextAttributes = memeTextAttribute
        self.bottomTextField.defaultTextAttributes = memeTextAttribute
        self.topTextField.textAlignment = NSTextAlignment.Center
        self.bottomTextField.textAlignment = NSTextAlignment.Center

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        if let image = self.imageView.image{
            self.shareButton.enabled = true
        }else {
            self.shareButton.enabled = false
        }
        
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubsrcibeToKeyboardNotifications()
    }
    
    // -------------------------------------
    // MARK: NotificationCenter
    // -------------------------------------

    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubsrcibeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    // -------------------------------------
    // MARK: Shift view when Keyboard Appear and Desappear
    // -------------------------------------

    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        var keyboardSize = NSValue()
        switch notification.name {
        case UIKeyboardWillShowNotification:
            keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        case UIKeyboardWillHideNotification:
            keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue // of CGRect
        default: break
        }
        if self.keyboardWillCoverTextField(keyboardSize){
            return keyboardSize.CGRectValue().height
        }
        return 0.0
    }
    
    func keyboardWillCoverTextField(keyboardSize: NSValue) -> Bool{
        let yFrameKeyboard = keyboardSize.CGRectValue().origin.y
        return yFrameKeyboard <= self.yFrameForTextFieldSelected ? true : false
    }
    
    // -------------------------------------
    // MARK: pickAnImage...
    // -------------------------------------

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        
        self.pickAnImageFromSource(.PhotoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        
        self.pickAnImageFromSource(.Camera)
    }
    
    func pickAnImageFromSource(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // -------------------------------------
    // MARK: UIImagePickerControllerDelegate
    // -------------------------------------
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)

        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // -------------------------------------
    // MARK: UITextFieldDelegate
    // -------------------------------------

    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        yFrameForTextFieldSelected = textField.frame.origin.y + textField.frame.size.height
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // -------------------------------------
    // MARK: Meme setup
    // -------------------------------------

    func save(memedImage: UIImage){
        var meme = Meme(topString: self.topTextField.text, bottomString: self.bottomTextField.text, image: self.imageView.image!, memedImage: memedImage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.append(meme)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        self.navigationController?.navigationBar.hidden = true
        self.toolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        self.navigationController?.navigationBar.hidden = false
        self.toolBar.hidden = false
        
        return memedImage

    }
    
    // -------------------------------------
    // MARK: Meme Share
    // -------------------------------------
    
    @IBAction func share(sender: UIBarButtonItem) {
        let memedImage = self.generateMemedImage()
        let shareViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        shareViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(memedImage)
            }
        }
        self.presentViewController(shareViewController, animated: true, completion: nil)
    }
        
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // -------------------------------------
    // MARK: Hide StatusBar
    // -------------------------------------

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

