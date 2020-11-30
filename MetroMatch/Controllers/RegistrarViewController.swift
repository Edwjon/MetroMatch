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
    @IBOutlet var nombreTextField: UITextField!
    @IBOutlet var apellidoTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    
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
        usernameTextField.font = UIFont(name: "Helvetica Neue", size: 16)
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.cornerRadius = 12
        
        //Password TExtfield
        passwordTextField.font = UIFont(name: "Helvetica Neue", size: 16)
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 12
        
        //Etiqueta MetroMatch
        registroLabel.font = UIFont(name: "Savoye LET", size: 50)
        registroLabel.textColor = .white
        
        //Boton Iniciar Sesión
        registrarButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        registrarButton.layer.masksToBounds = true
        registrarButton.layer.cornerRadius = 12
        let colorIzquierdaAmarillo = UIColor(red: 1, green: 0.73, blue: 0.004, alpha: 1)
        let colorDerechaNaranja = UIColor(red: 0.998, green: 0.417, blue: 0.298, alpha: 1)
        registrarButton.setGradientBackground(colorOne: colorDerechaNaranja, colorTwo: colorIzquierdaAmarillo)
        
        nombreTextField.font = UIFont(name: "Helvetica Neue", size: 16)
        nombreTextField.layer.masksToBounds = true
        nombreTextField.layer.cornerRadius = 12
        
        apellidoTextField.font = UIFont(name: "Helvetica Neue", size: 16)
        apellidoTextField.layer.masksToBounds = true
        apellidoTextField.layer.cornerRadius = 12
        
        emailTextField.font = UIFont(name: "Helvetica Neue", size: 16)
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 12
        
        loginButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        loginButton.tintColor = .white
    }
    

    func constrains() {
        
        registroLabel.translatesAutoresizingMaskIntoConstraints = false
        registroLabel.anchor(view.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 150, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 55)
        registroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nombreTextField.translatesAutoresizingMaskIntoConstraints = false
        nombreTextField.anchor(registroLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        nombreTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        apellidoTextField.translatesAutoresizingMaskIntoConstraints = false
        apellidoTextField.anchor(nombreTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        apellidoTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.anchor(apellidoTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.anchor(usernameTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.anchor(emailTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: 40)
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        registrarButton.translatesAutoresizingMaskIntoConstraints = false
        registrarButton.anchor(passwordTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 40)
        registrarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    
    
    
    @IBAction func registrar(_ sender: Any) {
        
//        let layout = UICollectionViewFlowLayout()
//        let vc = SurveyCollectionVC(collectionViewLayout: layout)
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        self.present(nav, animated: true, completion: nil)
        
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let username = usernameTextField.text, !username.isEmpty,
            let nombre = nombreTextField.text, !nombre.isEmpty,
            let apellido = apellidoTextField.text, !apellido.isEmpty else{
            print("Faltan campos para completar")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                // show account creation
                
                return
            }
            self.db.collection("users").document((authResult?.user.uid)!).setData([
                "firstName": nombre,
                "lastName": apellido,
                "email": email,
                "aboutMe": [],
                "id": authResult?.user.uid ?? "",
                "matches": [],
                "notification": [],
                "phone": "+587393086",
                "posts": [],
                "profilePic": "https://firebasestorage.googleapis.com/v0/b/metromatch-6771a.appspot.com/o/DefaultProfilePic.png?alt=media&token=035b79bd-bf5b-45e0-9f36-2b5e46ad1f03",
                "username": username
            ]){ err in
                if let err = err {
                    print("No se creo el usuario: ", err)
                } else {
                    print("Se creo el usuario")
                }
            }
            self.performSegue(withIdentifier: "tabBarRegistrar", sender: self)
        }
        
        let actionSheet = UIAlertController(title: "Alerta", message: "Por favor llena la siguiente encuesta para calcular tu compatiblidad con otros usuarios", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            
            let layout = UICollectionViewFlowLayout()
            let vc = SurveyCollectionVC(collectionViewLayout: layout)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true, completion: nil)
        }))
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: ViewController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
