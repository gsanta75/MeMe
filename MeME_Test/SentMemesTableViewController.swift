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
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if memes.isEmpty{
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            if let MeMeEditorVC = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as? MemeEditorViewController{
                MeMeEditorVC.firstPresent = true
                self.presentViewController(MeMeEditorVC, animated: false, completion: nil)
            }
        }
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let mDvc = segue.destinationViewController as? MeMeDetailViewController{
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let meme = memes[indexPath.row]
                mDvc.memeDetail = meme
            }
        }
    }
    
    

}
