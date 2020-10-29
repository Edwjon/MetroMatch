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
    weak var delegate: UserPressTheCell?
    var users = [User]()
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(handleCancel))
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
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
                    user.profilePic = document["profilePic"] as? String
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
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "@" + user.username!
        cell.detailTextLabel?.text = user.firstName! + " " + user.lastName!
        print(cell.textLabel?.text)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            let vc = segue.destination as! CrearPostViewController
            vc.labelText = "Testing"
         }
    }
    
}

class UserCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol UserPressTheCell: NSObjectProtocol
{
   func didUserPressTheCellWith(text: String)
}

