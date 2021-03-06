//
//  SentMemesCollectionViewController.swift
//  MeME_Test
//
//  Created by Pino on 03/07/15.
//  Copyright (c) 2015 GIUSEPPE SANTANIELLO. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme]!
    var cellSize: CGFloat!
    var cellSpace: CGFloat!
    
    let labelAttributeForCells = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellPadding: CGFloat = 2
        let numberCellsForLine: CGFloat = 4
        
        var cellSize = CGRectGetWidth(self.view.frame) / numberCellsForLine
        cellSize -= cellPadding
        
        let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
        flowLayout.minimumInteritemSpacing = cellPadding
        flowLayout.minimumLineSpacing = cellPadding
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
        
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        
        cell.topLabel.attributedText = NSAttributedString(string: meme.topString, attributes: labelAttributeForCells)
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomString, attributes: labelAttributeForCells)
        cell.topLabel.textAlignment = NSTextAlignment.Center
        cell.bottomLabel.textAlignment = NSTextAlignment.Center
        cell.imageView.image = meme.image
        
        return cell
    }
    
    /*
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let memeDVC = storyboard?.instantiateViewControllerWithIdentifier("MeMeDetailViewController") as? MeMeDetailViewController {
            let meme = self.memes[indexPath.row]
            memeDVC.memeDetail = meme
            self.navigationController?.pushViewController(memeDVC, animated: true)
        }
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMeMeDetail" {
            let indexPath = collectionView.indexPathsForSelectedItems()[0] as! NSIndexPath
            let meme = memes[indexPath.row]
            if let mDvc = segue.destinationViewController as? MeMeDetailViewController {
                mDvc.memeDetail = meme
            }
        }
    }
    
}
