//
//  ViewController.swift
//  MemeMe
//
//  Created by Shane Richards on 4/19/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        presentImagePicker(source: .photoLibrary)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        presentImagePicker(source: .camera)
    }
    
    func presentImagePicker(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()

        pickerController.delegate = self
        pickerController.sourceType = source

        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
