//
//  ViewController.swift
//  MemeMe
//
//  Created by Shane Richards on 4/19/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // added to manage managing magic strings
    
    enum MemeTextDefault: String {
        case top = "TOP", bottom = "BOTTOM"
    }
    
    let memeAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth:  -5.0
    ]
    
    func configureTextField(textField: UITextField, text: MemeTextDefault) {
        textField.defaultTextAttributes = memeAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.text = text.rawValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEditor()
        
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    func configureEditor() {
        imageView.image = nil
        shareButton.isEnabled = false
        imageView.backgroundColor = .black
        configureTextField(textField: topTextField, text: .top)
        configureTextField(textField: bottomTextField, text: .bottom)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        shareButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func save() {
        let memeImage = generateMemedImage()
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memeImage: memeImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
//        print("new meme: \(meme)")
//        print("appDelegate.memes: \(appDelegate.memes)")
    }
    
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        self.save()
//        let image = generateMemedImage()
//        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//
//        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
//            if completed && error == nil {
//                self.save()
//            }
//        }
//
//        present(controller, animated: true)
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
        print("cancel clicked")
        self.navigationController?.popViewController(animated: true)
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
