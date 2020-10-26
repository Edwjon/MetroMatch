//
//  RegistrarViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/24/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegistrarViewController: UIViewController {

    @IBOutlet var registroLabel: UILabel!
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var registrarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        constrains()
        
        registroLabel.textColor = .black
    }
    

    func constrains() {
        
        registroLabel.translatesAutoresizingMaskIntoConstraints = false
        registroLabel.anchor(view.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 40)
        registroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.anchor(registroLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.anchor(usernameTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        registrarButton.translatesAutoresizingMaskIntoConstraints = false
        registrarButton.anchor(passwordTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 40)
        registrarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    
    
    
    @IBAction func registrar(_ sender: Any) {
        let layout = UICollectionViewFlowLayout()
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Faltan campos para completar")
            return
        }
        
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            guard error == nil else {
                // show account creation
                
                return
            }
            print("Se ha creado el usuario")
        }
        
        //performSegue(withIdentifier: "presentRegister", sender: self)
        //self.present(CollectionViewController(collectionViewLayout: layout), animated: true, completion: nil)
    }
    

    
}
