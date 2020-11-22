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
    
    
    @IBAction func cambiarPicAction(_ sender: Any) {
    }
    
    @IBAction func updateAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
