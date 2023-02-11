//
//  AddNoteViewController.swift
//  SimpleNoteApplication
//
//  Created by Furkan Kozmaç on 11.02.2023.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePic))
        imageView.addGestureRecognizer(imageGestureRecognizer)
        
    }
    
    @objc func choosePic(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true)
    }

    @IBAction func saveOnClick(_ sender: Any) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let myNotes = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context)
        
        myNotes.setValue(titleTextField.text, forKey: "title")
        myNotes.setValue(noteTextField.text, forKey: "note")
        
        let convertMyImageToData = imageView.image?.jpegData(compressionQuality: 0.5)
        myNotes.setValue(convertMyImageToData, forKey: "image")
        
        myNotes.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("Note saved.")
        }catch{
            print("There is an error.")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("dataEntered"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
}
