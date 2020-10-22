//
//  ViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/20/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var usernameTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.placeholder = "Ingresa tu username"
        usernameTextfield.backgroundColor = .gray
//        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
//        usernameTextfield.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//        usernameTextfield.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
//        usernameTextfield.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        usernameTextfield.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
        
    }
    
    
    

    

}
