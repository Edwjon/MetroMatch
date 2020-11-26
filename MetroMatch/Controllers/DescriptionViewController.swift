//
//  DescriptionViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/24/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var editable = false
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet var profileBackgroundImage: UIImageView!
    
    @IBOutlet var updateButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var profileImage: UIImageView!
    var user = User();
    let db = Firestore.firestore()
    @IBOutlet var tableView: UITableView!
    
    var descripcion = ""
    var hobbies = ""
    var queHago = ""
    
    var idUsuario = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hola")
        print("hola")
        print(idUsuario)
        
        
        
//        let docRef = db.collection("users").document(idUsuario ?? "")
//
//        docRef.getDocument { (userDoc, error) in
//            if let userDoc = userDoc, userDoc.exists {
//                let userData = userDoc.data().map(String.init(describing:)) ?? "nil"
//                self.user.username = userDoc.data()["username"] as? String
//                self.user.firstName = userDoc.data()["firstName"] as? String
//                self.user.lastName = userDoc.data()["lastName"] as? String
//                self.user.profilePic = userDoc.data()["profilePic"] as? String
//                print("the user is \(self.user)")
//            } else {
//                print("Document does not exist")
//            }
//        }
        
        
        
        
        //Se puede editar ya que se entró desde el own perfil
        if editable {
            updateButton.isHidden = false
            editButton.isHidden = false
        } else {
            updateButton.isHidden = true
            editButton.isHidden = true
        }
        
        title = "Edit Profile"
        tableView.allowsSelection = false

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ProfileCell2.self, forCellReuseIdentifier: "cell2")
        tableView.register(ProfileCell3.self, forCellReuseIdentifier: "cell3")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 170
        
        self.db.collection("users").document(idUsuario).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                self.user.username = document["username"] as? String
                self.user.firstName = document["firstName"] as? String
                self.user.lastName = document["lastName"] as? String
                self.user.profilePic = document["profilePic"] as? String
                self.setupInterface()
            } else {
                print("Document does not exist")
            }
        }
          
    }
    
    
    func setupInterface() {
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.contentMode = .scaleToFill
        print("Testing user")
        print(self.user.firstName)
        profileImage.downloaded(from: user.profilePic!)
        NameLabel.text = user.firstName! + " " + user.lastName!
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
            
            //Aqui se setean los textos. Ejemplo:
            //cell.descripcion.text = "Lo que sea"
            //descripcion = "Algo"
            
            return cell
        }
        
        if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ProfileCell2
            
            //Aqui se setean los textos. Ejemplo:
            //cell.hobbies.text = "Lo que sea"
            //hobbies = "Algo"
            
            return cell
        }
        
        if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! ProfileCell3
            
            //Aqui se setean los textos. Ejemplo:
            //cell.queBusco.text = "Lo que sea"
            //queHago = "Algp"
            
            return cell
        }

        return UITableViewCell()
    }
    
    @IBAction func update(_ sender: Any) {
        //Usas lo que tenga el usuario en el momento
        //Usas las variales descripcion, hobbies, queHago
    }
    
    
    
}
