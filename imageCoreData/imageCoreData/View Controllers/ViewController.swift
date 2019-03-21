//
//  ViewController.swift
//  imageCoreData
//
//  Created by Nelson Gonzalez on 3/20/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageImageView: UIImageView!
    
    var image: UIImage? = nil
    var currentVC: UIViewController!
    
    let postController = PostController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(postController.post.count)
    }
    
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            myPickerController.allowsEditing = true
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.allowsEditing = true
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            
            imageImageView.image = imageSelected
            
        } else if let imageSelectedOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageSelectedOriginal
            imageImageView.image = imageSelectedOriginal
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func selectImageButtonPressed(_ sender: UIButton) {
        
        showActionSheet(vc: self)
    }
    
    @IBAction func saveImageButtonPressed(_ sender: UIButton) {
        
        let documentsDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let idString = UUID().uuidString
        
         let imageURL = documentsDir.appendingPathComponent(idString).appendingPathExtension("jpeg")
        
        guard let img = image, let imageData = img.jpegData(compressionQuality: 1) else {return}
        
        do {
            try imageData.write(to: imageURL)
                    } catch {
                        NSLog("Error writing image data to documents directory: \(error)")
                    }
    
        postController.create(with: idString) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            self.imageImageView.image = nil
            
        }
    }
    
    @IBAction func toSavedImagesButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSavedImages", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ImageTableViewController
        destinationVC?.postController = postController
    }
    
    
}

