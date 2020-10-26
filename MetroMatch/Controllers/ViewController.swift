//
//  ViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/20/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet var usernameTextfield: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBOutlet var iniciarSesionButton: UIButton!
    
    @IBOutlet var metrMatchLabel: UILabel!
    
    @IBOutlet var registrarButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.placeholder = "Ingresa tu username"
        usernameTextfield.backgroundColor = .gray
        
        metrMatchLabel.textColor = .black
        registrarButton.backgroundColor = .orange
        
        
        constrains()
    }
    
    
    func constrains() {
        
        metrMatchLabel.translatesAutoresizingMaskIntoConstraints = false
        metrMatchLabel.anchor(view.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 40)
        //metrMatchLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        metrMatchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.anchor(metrMatchLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        usernameTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.anchor(usernameTextfield.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        passwordTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        iniciarSesionButton.translatesAutoresizingMaskIntoConstraints = false
        iniciarSesionButton.anchor(passwordTextfield.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 40)
        iniciarSesionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        registrarButton.translatesAutoresizingMaskIntoConstraints = false
        registrarButton.anchor(nil, left: nil, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 50, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 40)
        registrarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    @IBAction func iniciarSesion(_ sender: Any) {
        
        guard let username = usernameTextfield.text, !username.isEmpty,
              let password = passwordTextfield.text, !password.isEmpty else {
            print("Faltan campos para completar")
            return
        }
        
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            guard error == nil else {
                // show account creation
                
                return
            }
            print("Se ha inicado sesion  del usuario")
            self.performSegue(withIdentifier: "presentLogin", sender: self)
        }
        //performSegue(withIdentifier: "presentLogin", sender: self)
//        let layout = UICollectionViewFlowLayout()
//        self.present(CollectionViewController(collectionViewLayout: layout), animated: true, completion: nil)
    }
    
    
    @IBAction func registrar(_ sender: Any) {
        performSegue(withIdentifier: "presentRegistrar", sender: self)
        //self.present(RegistrarViewController(), animated: true, completion: nil)
    }
    
    

}
