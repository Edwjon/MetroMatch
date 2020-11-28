//
//  OwnProfileVC.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/21/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import Firebase

class OwnProfileVC: UIViewController {

    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var changePicButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var hobbiesTextView: UITextView!
    @IBOutlet var quienSoyTextView: UITextView!
    
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var queBuscoTextView: UITextView!
    override func viewDidLoad() {
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
        guard let toUpload = profilePic.image, let data = toUpload.jpegData(compressionQuality: 0.4) else {
            print("No se pudo enviar su foto al servidor")
            return
        }
        
        let toUploadName = UUID().uuidString
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
