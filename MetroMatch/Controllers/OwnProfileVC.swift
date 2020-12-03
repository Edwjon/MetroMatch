//
//  OwnProfileVC.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/21/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class OwnProfileVC: UIViewController {
    
    let db = Firestore.firestore()
    
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var changePicButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var hobbiesTextView: UITextView!
    @IBOutlet var quienSoyTextView: UITextView!
    
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var queBuscoTextView: UITextView!
    
    let _user = User()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        if let user = user {
          
            self.db.collection("users").document(user.uid).getDocument { (userr, err) in
                
                if let userr = userr, userr.exists {
                    self._user.firstName = userr["firstName"] as? String
                    self._user.lastName = userr["lastName"] as? String
                    self._user.hobbies = userr["hobbies"] as? String
                    self._user.quienSoy = userr["quienSoy"] as? String
                    self._user.queBusco = userr["queBusco"] as? String
                    self._user.profilePic = userr["profilePic"] as? String
                    
                    self.profilePic.downloaded(from: self._user.profilePic!)
                    self.nameTextField.text = self._user.firstName
                    self.lastNameTextField.text = self._user.lastName
                    self.hobbiesTextView.text = self._user.hobbies
                    self.quienSoyTextView.text = self._user.quienSoy
                    self.queBuscoTextView.text = self._user.queBusco
                
                } else {
                    print("Error mamalon")
                }
            }
            
//          let uid = user.uid
//          let email = user.email
//          let photoURL = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
          // ...
        }

        hobbiesTextView.backgroundColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        hobbiesTextView.layer.masksToBounds = true
        queBuscoTextView.backgroundColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        quienSoyTextView.backgroundColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        
        profilePic.isUserInteractionEnabled = true
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
        profilePic.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagePicker))
        profilePic.addGestureRecognizer(tapGesture)
    }
    
    @objc func imagePicker() {
        presentPhotoActionSheet()
    }
    
    
    @IBAction func cambiarPicAction(_ sender: Any) {
        presentPhotoActionSheet()
    }
    
    @IBAction func updateAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print(profilePic)
        
        guard let toUpload = profilePic.image, let data = toUpload.jpegData(compressionQuality: 0.4) else {
            print("No se pudo enviar su foto al servidor")
            return
        }
        
        
        let toUploadName = UUID().uuidString + ".jpg"
        let toUploadReference = Storage.storage().reference().child("images").child(toUploadName)
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        toUploadReference.putData(data, metadata: uploadMetadata) { (downloadMetadata, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            toUploadReference.downloadURL { (url, err) in
                if let err = err {
                    print("oH NO GOT AN ERROR!!")
                    print(err.localizedDescription)
                    return
                }
                print("PUT IS COMPLETE AND GOT THIS BACK \(downloadMetadata)")
                guard let url = url else {
                    print("ALGO SALIO MAL MANAO, INTENTA OTRA VEZ")
                    return
                }
                let urlString = url.absoluteString
                let userID = Auth.auth().currentUser!.uid
                print("User ID traido es " + userID)
                
                let userUpdate = self.db.collection("users").document(userID)
                // Cambiando la referencia de la foto de perfil en la aplicacion
                userUpdate.updateData([
                    "profilePic": urlString
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                
            }
        }
        
        let hobbies = hobbiesTextView.text
        let quienSoy = quienSoyTextView.text
        let queBusco = queBuscoTextView.text
        let firstName = nameTextField.text
        let lastName = lastNameTextField.text
        let userID = Auth.auth().currentUser!.uid
        let userUpdate = self.db.collection("users").document(userID)
        // Cambiando la referencia de la foto de perfil en la aplicacion
        userUpdate.updateData([
            "firstName": firstName,
            "lastName": lastName,
            "hobbies": hobbies,
            "quienSoy": quienSoy,
            "queBusco": queBusco
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
        
    }
    
    

}

extension OwnProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Selecciona tu imagen de perfil por favor", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Subir Foto", style: .default, handler: { [weak self] _ in
            
            self?.presentPhotoLibrary()
        }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func presentPhotoLibrary() {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = self
        vc.sourceType = .photoLibrary
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.profilePic.image = imageSelected
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
