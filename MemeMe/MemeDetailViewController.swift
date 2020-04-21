//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Shane Richards on 4/20/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    static var identifier = "MemeDetailViewController"

    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = meme.memeImage
    }
}
