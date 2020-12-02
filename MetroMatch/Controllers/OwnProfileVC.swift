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
    override func viewDidLoad() {
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let email = user.email
          let photoURL = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
          // ...
        }
        
        
        
        super.viewDidLoad()

        hobbiesTextView.backgroundColor = .orange
        hobbiesTextView.layer.masksToBounds = true
        queBuscoTextView.backgroundColor = .orange
        quienSoyTextView.backgroundColor = .orange
        
        hobbiesTextView.text = "HolaHolaHolaHolaHolaHolaHolaHolaHola"
        quienSoyTextView.text = "HolaHolaHolaHolaHolaHolaHolaHolaHola"
        queBuscoTextView.text = "HolaHolaHolaHolaHolaHolaHolaHolaHola"
        
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
        
        let toUploadName = UUID().uuidString
        let toUploadReference = Storage.storage().reference().child("images").child(toUploadName)
        
        toUploadReference.putData(data, metadata: nil) { (metadata, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            toUploadReference.downloadURL { (url, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
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
