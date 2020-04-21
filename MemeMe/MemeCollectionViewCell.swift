//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Shane Richards on 4/20/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit


class MemeCollectionViewCell: UICollectionViewCell {
    public static var reuseIdentifier = "MemeCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with meme: Meme) {
        imageView.image = meme.memeImage
    }
}
