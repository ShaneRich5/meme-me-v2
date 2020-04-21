//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Shane Richards on 4/20/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes = [Meme]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        self.memes = appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()
    }
}


