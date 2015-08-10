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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        self.imageView.image = memeDetail.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editMeme" {
            if let editVc = segue.destinationViewController as? MemeEditorViewController {
                editVc.editMode = true
                editVc.meme = self.memeDetail
            }
        }
    }
    
}
