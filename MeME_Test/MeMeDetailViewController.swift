//
//  MeMeDetailViewController.swift
//  MeME_Test
//
//  Created by GSanta on 18/07/15.
//  Copyright (c) 2015 GIUSEPPE SANTANIELLO. All rights reserved.
//

import UIKit

class MeMeDetailViewController: UIViewController {
    
    var memeDetail: Meme!
    @IBOutlet weak var imageView: UIImageView!
    var rightBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "presentMemeEditorVC:")
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }

    func presentMemeEditorVC(sender: UIBarButtonItem){
        if let memeEditorVC = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as? MemeEditorViewController{
            memeEditorVC.meme = self.memeDetail
            self.presentViewController(memeEditorVC, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        self.imageView.image = memeDetail.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }


}
