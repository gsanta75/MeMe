//
//  SentMemesTableViewController.swift
//  MeME_Test
//
//  Created by Pino on 03/07/15.
//  Copyright (c) 2015 GIUSEPPE SANTANIELLO. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var memes: [Meme]!
    
    let labelAttributeForCells = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
        
//        if memes.count == 0 {
//            self.presentMemeEditorVC()
//        }
        self.tableView.reloadData()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemesCells") as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.imageViewSentCell.image = meme.image
        cell.labelSentCell.text = meme.topString + "..." + meme.bottomString
        
        cell.topLabelSentCell.attributedText = NSAttributedString(string: meme.topString, attributes: self.labelAttributeForCells)
        cell.bottomLabelSentCell.attributedText = NSAttributedString(string: meme.bottomString, attributes: self.labelAttributeForCells)
        
        return cell
    }
    
//    func presentMemeEditorVC(){
//        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let memeEditorVC = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
//        self.presentViewController(memeEditorVC, animated: true, completion: nil)
//
//    }
//
//    @IBAction func addNewMemeImage(sender: AnyObject) {
//        self.presentMemeEditorVC()
//    }
    

}
