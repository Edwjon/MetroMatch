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
        
        setupIntertace()
        
        constrains()
    }
    
    
    
    func setupIntertace() {
        //UserName TExtField
        usernameTextfield.placeholder = "Ingresa tu username"
        usernameTextfield.font = UIFont.systemFont(ofSize: 16) //Aqui va el font del usernameTextfield
        usernameTextfield.layer.masksToBounds = true
        usernameTextfield.layer.cornerRadius = 12
        
        //Password TExtfield
        passwordTextfield.font = UIFont.systemFont(ofSize: 16) //Aqui va el font del usernameTextfield
        passwordTextfield.layer.masksToBounds = true
        passwordTextfield.layer.cornerRadius = 12
        
        //Etiqueta MetroMatch
        let customFont = UIFont(name: "LobsterTwo-Italic", size: UIFont.labelFontSize)
        metrMatchLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
        metrMatchLabel.textColor = .white
        
        //Boton Iniciar Sesión
        iniciarSesionButton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont!)
        iniciarSesionButton.layer.masksToBounds = true
        iniciarSesionButton.layer.cornerRadius = 12
        let colorIzquierdaAmarillo = UIColor(red: 1, green: 0.73, blue: 0.004, alpha: 1)
        let colorDerechaNaranja = UIColor(red: 0.998, green: 0.417, blue: 0.298, alpha: 1)
        iniciarSesionButton.setGradientBackground(colorOne: colorDerechaNaranja, colorTwo: colorIzquierdaAmarillo)
        
        //Boton registrar
        registrarButton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont!)
        registrarButton.tintColor = .white
        
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
                
                let alert = UIAlertController(title: "Error", message: "Campos inválidos. Por favor ingrese datos correctos en los campos de texto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            return
        }
        
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            guard error == nil else {
                // show account creation
                
                let alert = UIAlertController(title: "Error", message: "Usuario o contraseña inválidos. Por favor ingrese un usuario válido", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            print("Se ha inicado sesion del usuario")
            self.performSegue(withIdentifier: "presentLogin", sender: self)
        }
        
    }
    
    
    @IBAction func registrar(_ sender: Any) {
        performSegue(withIdentifier: "presentRegistrar", sender: self)
    }

}


extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}