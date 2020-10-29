//
//  SelectUserController.swift
//  MetroMatch
//
//  Created by Reichel  Larez  on 10/28/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SelectUserController: UITableViewController {
    let db =  Firestore.firestore()
    var users = [User]()
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(handleCancel))
        fetchUsers()
    }
    
    func fetchUsers(){
        db.collection("users").getDocuments(){ (users, err) in
            if let err = err {
                print("Ocurrio un error", err)
            } else {
                for document in users!.documents {
                    let user = User()
                    user.firstName = document["firstName"] as? String
                    user.lastName = document["lastName"] as? String
                    user.email = document["email"] as? String
                    user.username = document["username"] as? String
                    self.users.append(user)
                }
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                print("testing")
                print(self.users)
            }
        }
    }

    @objc func handleCancel(){
        dismiss(animated: true,completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.username
        return cell
    }
    
}
