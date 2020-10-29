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
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet var profileBackgroundImage: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var profileImage: UIImageView!
    var user = User();
    let db = Firestore.firestore()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let userId = Auth.auth().currentUser
        if let userId = userId {
            db.collection("users").document(userId.uid).getDocument{(userLogged, err) in
                if let userLogged = userLogged, userLogged.exists{
                    self.user.firstName = userLogged.data()!["firstName"] as? String
                    self.user.lastName = userLogged.data()!["lastName"] as? String
                    self.user.profilePic = userLogged.data()!["profilePic"] as? String
                    print(self.user.firstName)
                    self.setupInterface()
                } else {
                    print("El usuario no existe")
                }
            }
        } else {
            print("Usuario no loggeado")
        }
        
    }
    
    
    func setupInterface() {
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.contentMode = .scaleToFill
        profileImage.downloaded(from: user.profilePic!)
        NameLabel.text = user.firstName! + " " + user.lastName!
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
    
    
    @IBAction func update(_ sender: Any) {
    }
    
    
}
