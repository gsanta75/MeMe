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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = memeDetail.memedImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
