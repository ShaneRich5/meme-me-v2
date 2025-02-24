//
//  SentMemeListViewController.swift
//  MemeMe
//
//  Created by Shane Richards on 4/20/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit

class SentMemeListViewController: UIViewController {
    let cellIdentifier = "MemeCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }
}

extension SentMemeListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        let cellIndex = (indexPath as NSIndexPath).row
        let meme = memes[cellIndex]
        
        // Set the name and image
        cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"
        cell.imageView?.image = meme.memeImage
        
        return cell
    }
}

extension SentMemeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: MemeDetailViewController.identifier) as! MemeDetailViewController
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        detailController.meme = meme
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
