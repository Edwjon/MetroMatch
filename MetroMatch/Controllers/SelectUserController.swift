//
//  SelectUserController.swift
//  MetroMatch
//
//  Created by Reichel  Larez  on 10/28/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class SelectUserController: UITableViewController {

    let db =  Firestore.firestore()
    weak var delegate: UserPressTheCell?
    var users = [User]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    
                    if document.documentID != Auth.auth().currentUser?.uid {
                        self.users.append(user)
                    }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.textLabel?.text = "@" + user.username!
        cell.detailTextLabel?.text = user.firstName! + " " + user.lastName!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: CrearPostViewController = mainStoryboard.instantiateViewController(withIdentifier: "crear") as! CrearPostViewController
        vc.modalPresentationStyle = .fullScreen
        vc.nombreTextField = users[indexPath.row].username ?? "No se seleccionó usuario"
        vc.imagenDePerfil = users[indexPath.row].profilePic ?? "https://firebasestorage.googleapis.com/v0/b/metromatch-6771a.appspot.com/o/IMG_8386.png?alt=media&token=942c020a-d0b9-4d93-b5fc-2ef1f4459596"
        self.present(vc, animated: true, completion: nil)
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

