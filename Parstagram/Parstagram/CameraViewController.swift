//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Oberon on 10/14/21.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet var commentField: UITextField!
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentField.text
        post["author"] = PFUser.current()!
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success{
                print("saved!")
                self.dismiss(animated: true, completion: nil)
            
            } else {
                print("error!")
            }
        }
    }
    
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 350, height: 350)
        let scaledImage = image.af.imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}
