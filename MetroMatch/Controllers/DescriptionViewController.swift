//
//  DescriptionViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/24/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseStorage

class DescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var db: Firestore!
    
    @IBOutlet var profileBackgroundImage: UIImageView!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        let authListener = Auth.auth().addStateDidChangeListener { [self] (auth, user) in
              
            if user != nil {
                //obtendo el id y el email del usuario actual si se encuentra
                let currentUser = Auth.auth().currentUser
                if let currentUser = user {
                  // The user's ID, unique to the Firebase project.
                  let uid = currentUser.uid
                    //me traigo el documento de firestore
                    let userData = Firestore.firestore().collection("users").document(uid)
                    
                    userData.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data()//.map(String.init(describing:)) ?? "nil"
                            print("Document data: \(String(describing: dataDescription))")
                            let name = dataDescription?["firstName"]
                            let lastName = dataDescription?["lastName"]
                            print("El nombre es \(String(describing: name))")
                            print("El apellido es \(String(describing: lastName))")
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                    
                    print("El usuario \(String(describing: uid)) ha sido autenticado")
                    
                    
                  // ...
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Su usuario no ha podido ser autenticado", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ProfileCell2.self, forCellReuseIdentifier: "cell2")
        tableView.register(ProfileCell3.self, forCellReuseIdentifier: "cell3")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 170
        
        setupInterface()
    }
    
    
    func setupInterface() {
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.contentMode = .scaleToFill
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
            return cell
        }
        
        if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ProfileCell2
            return cell
        }
        
        if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! ProfileCell3
            return cell
        }

        return UITableViewCell()
    }

}
