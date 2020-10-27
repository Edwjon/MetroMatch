//
//  RegistrarViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/24/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class RegistrarViewController: UIViewController {

    @IBOutlet var registroLabel: UILabel!
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var registrarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        constrains()
    }
    
    let db = Firestore.firestore()
    func setupInterface() {
        //UserName TExtField
        usernameTextField.placeholder = "Ingresa tu username"
        usernameTextField.font = UIFont.systemFont(ofSize: 16) //Aqui va el font del usernameTextfield
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.cornerRadius = 12
        
        //Password TExtfield
        passwordTextField.font = UIFont.systemFont(ofSize: 16) //Aqui va el font del usernameTextfield
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 12
        
        //Etiqueta MetroMatch
        let customFont = UIFont(name: "LobsterTwo-Italic", size: UIFont.labelFontSize)
        registroLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
        registroLabel.textColor = .white
        
        //Boton Iniciar Sesión
        registrarButton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont!)
        registrarButton.layer.masksToBounds = true
        registrarButton.layer.cornerRadius = 12
        let colorIzquierdaAmarillo = UIColor(red: 1, green: 0.73, blue: 0.004, alpha: 1)
        let colorDerechaNaranja = UIColor(red: 0.998, green: 0.417, blue: 0.298, alpha: 1)
        registrarButton.setGradientBackground(colorOne: colorDerechaNaranja, colorTwo: colorIzquierdaAmarillo)
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
            self.db.collection("users").document((authResult?.user.uid)!).setData([
                "email": username
            ]){ err in
                if let err = err {
                    print("No se creo el usuario")
                } else {
                    print("Se creo el usuario")
                }
            }
            print("Se ha creado el usuario")
            //self.performSegue(withIdentifier: "presentRegister", sender: self)
            self.crearTabBar()
        }
        
        
        
        
        
        //performSegue(withIdentifier: "presentRegister", sender: self)
        //self.present(CollectionViewController(collectionViewLayout: layout), animated: true, completion: nil)
    }
    

    
}
