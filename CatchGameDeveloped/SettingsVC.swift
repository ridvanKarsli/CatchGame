//
//  SettingsVC.swift
//  CatchGameDeveloped
//
//  Created by Rıdvan KARSLI on 30.01.2024.
//

import UIKit
import CoreData

class SettingsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var dereceOfDifficulty: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        imageView.addGestureRecognizer(imageTap)
        
        saveButton.isEnabled = false
    }
    

    @objc func tapImage(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        saveButton.isEnabled = true
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        //userDefoults
        var derece = 1.0
        if dereceOfDifficulty.text == "1"{
            derece = 1.0
        }else if dereceOfDifficulty.text == "2"{
            derece = 0.75
        }else if dereceOfDifficulty.text == "3"{
            derece = 0.5
        }
        UserDefaults.standard.setValue(derece, forKey: "derece")
        
        //save another
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newProfile = NSEntityDescription.insertNewObject(forEntityName: "GameScore", into: context)
        
        newProfile.setValue(nameText.text, forKey: "name")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        newProfile.setValue(data, forKey: "image")
        
        do{
            try context.save()
            navigationController?.popViewController(animated: true)
        }catch{
            
        }
         
    }
         
    
}
