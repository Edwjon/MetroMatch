//
//  DescriptionController+handlers.swift
//  MetroMatch
//
//  Created by Reichel  Larez  on 10/29/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import Firebase

extension DescriptionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func editProfilePic(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

