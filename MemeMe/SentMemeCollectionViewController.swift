//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Shane Richards on 4/20/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UIViewController {

    var memes = [Meme]()
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        self.memes = appDelegate.memes
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.reloadData()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}

extension SentMemeCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCollectionViewCell.reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.configure(with: meme)
        return cell
    }
}

extension SentMemeCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: MemeDetailViewController.identifier) as! MemeDetailViewController
        let meme = self.memes[(indexPath as NSIndexPath).row]
        detailController.meme = meme
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
