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

//    create an outlet for the confidence label
    @IBOutlet weak var confidenceLabel: UILabel!
    
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
            
//            create a constant called "ciimage" (Core Image image) from the standard UIImage "userPickedImage"
//            use a guard-let statement to make sure the CIImage is created, and will throw an error if CIImage creation is unsuccessful
            guard let ciimage = CIImage(image: userPickedImage) else {fatalError("Could not convert UIImage to CIImage")}
            
//            detect the image
            detect(ciimage)
            
            
        }
        
//        once the image has been retrieved, dismiss the image picker
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
        
//    create a function to process the image
    func detect(_ image: CIImage) {
        
//        create a model for the machine learning
        
//        set "model" equal to the VNCoreMLModel, which acts as a container for the CoreML Model (which in this case is called Inceptionv3)
//        create the VNCoreMLModel object from the Inceptionv3 ML Model
        
//        VNCoreMLModel comes from the Vision framework
        
//        creating the VNCoreMLModel can result in an error, so the try? keyword tries to complete the task
//        however, try? returns an optional, so using a guard-let will throw an error if creating the VNCoreMLModel fails, as there is no point to move ob
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {fatalError("Loading CoreML model failed")}
        
//        create a Vision CoreML request from the model we made earlier
//        the request also provides a completion handler
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
//            here, we want to process the results of the request
//            optionally downcast the results from [Any]? to [VNClassificationObservation]
            
//            put this in a guard-let statement since the code must stop if the results are not able to be retrieved
            guard let results = request.results as? [VNClassificationObservation] else {fatalError("Model failed to process image")}
            
//            create a variable for the first (and most accurate) object found
            if let firstResult = results.first {

//                let topTwoResults = results.prefix(2)
                
//                uses the topTwoResults to convert [VNClassificationObservation] to [(confidence: VNConfidence, identifier: String)]
                
//                $0 always refers to the first parameter of a closure, which in the case of the "map" function, simply refers to each of the top two results
//                $1 refers to the second parameter, etc.
                
//                set the confidence property of each of the tuples equal to the confidence property of each of the top two results
//                set the identifier property of each of the tuples equal to the identifier property of each of the top two results
                
//                map essentially creates a new list by looping through another list
                
//                let formattedResults = topTwoResults.map { (confidence: $0.confidence, identifier: $0.identifier) }

//                display the most accurate item found  in the navigation bar
                self.navigationItem.title = results.first?.identifier
                
                self.confidenceLabel.text = "Confidence level: \(firstResult.confidence * 100)%"
                
            }
            
        }
        
//        create a handler to specify what image must be processed
//        use "image" as the image that needs to be passed in
        let handler = VNImageRequestHandler(ciImage: image)
        
//        try to
        do {
            
//            try to perform a request with the request that was made earlier
            try handler.perform([request])
            
//        if there are errors
        } catch {
            
//            print out the results
            print("Failed to perform request, \(error)")
        }
        
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

