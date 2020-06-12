//
//  ViewController.swift
//  SeeFood
//
//  Created by Narayan Sajeev on 6/11/20.
//  Copyright © 2020 Narayan Sajeev. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    create an outlet for the image view
    @IBOutlet weak var imageView: UIImageView!
    
//    create a UIImagePickerController object, which manages taking pictures
    let imagePicker = UIImagePickerController()
    
//    once the view loads up
    override func viewDidLoad() {
        
//        run the default code
        super.viewDidLoad()
        
//        additionally,
//        set the delegate of the image picker to this class
        imagePicker.delegate = self

//        if a camera is available on the device (ex: physical device)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {

//            set the source type of the image picker as a camera
            imagePicker.sourceType = .camera

//        if there is no available camera on the device (ex: a simulator)
        } else {
            
//            set the source type of the image picker as the saved photos album
            imagePicker.sourceType = .savedPhotosAlbum
        }

//        make sure the user is not able to edit the photos (i.e crop it, change the colors, add filters, etc.)
        imagePicker.allowsEditing = false
        
        
    }

        
//    tells the delegate that the user picked a still image or movie
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        set "userPickedImage" equal to the image the user just took
//        retrieve the taken photo through "UIImagePickerController.InfoKey.originalImage"
//        optionally downcast the image from Any? to UIImage?
//        and optionally bind that value to the "userPickedImage"
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
//            set the image of the imageView equal to the photo the user just took
            imageView.image = userPickedImage
            
        }
        
//        once the image has been retrieved, dismiss the image picker
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
        
//    if the camera button is tapped
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
//        present the image picker view controller
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}


//MARK: - More on Comments
    
/**
    An example of using a *code voice*
    Show Swift elements such as `for` and `let` as monspaced code font
    An example of using *strong*
    A **strong * (asterisk)** is on this line.
    __A strong line__.
    /// This line has a word with *emphasis*.
    /// This line uses _emphasis for the last six words_.
*/
//-----------------------------------------------------

/*
    An example of using a *code voice*
    Show Swift elements such as `for` and `let` as monspaced code font
    An example of using *strong*
    A **strong * (asterisk)** is on this line.
    __A strong line__.
    /// This line has a word with *emphasis*.
    /// This line uses _emphasis for the last six words_.
*/

