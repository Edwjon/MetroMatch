//
//  OwnProfileVC.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/21/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

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
        
        profilePic.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPic))
        profilePic.addGestureRecognizer(tapGesture)

        hobbiesTextView.backgroundColor = .orange
        hobbiesTextView.layer.masksToBounds = true
        queBuscoTextView.backgroundColor = .orange
        quienSoyTextView.backgroundColor = .orange
        
        hobbiesTextView.text = "HolaHolaHolaHolaHolaHolaHolaHolaHola"
        quienSoyTextView.text = "HolaHolaHolaHolaHolaHolaHolaHolaHola"
        queBuscoTextView.text = "HolaHolaHolaHolaHolaHolaHolaHolaHola"
        profilePic.backgroundColor = .orange
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
        profilePic.layer.masksToBounds = true
    }
    
    @objc func didTapPic() {
        alertSheet()
    }
    
    
    @IBAction func cambiarPicAction(_ sender: Any) {
    }
    
    @IBAction func updateAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


extension OwnProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func alertSheet() {
        
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Como te gustaría escoger tu foto de perfil?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            
            self?.choosePhoto()
            
        }))
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func choosePhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        
        self.profilePic.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
