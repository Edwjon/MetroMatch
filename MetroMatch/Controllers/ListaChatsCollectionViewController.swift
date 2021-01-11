//
//  ListaChatsCollectionViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/30/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

private let reuseIdentifier = "Cell"


class ListaChatsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let db = Firestore.firestore()
    var chats = [Chat]()
    var users = [User]()
    let myGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()

        collectionView.backgroundColor = .white
        self.collectionView!.register(ListaChatsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchChats()
    }
}


// MARK: - CollectionView -
extension ListaChatsCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListaChatsCell
        
        cell.imagenPerfil.downloaded(from: users[indexPath.item].profilePic ?? "")
        cell.nombreUsuario.text = (users[indexPath.item].firstName ?? "Edward") + " " + (users[indexPath.item].lastName ?? "Pizzurro")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: ChatViewController = mainStoryboard.instantiateViewController(withIdentifier: "chat") as! ChatViewController
        vc.modalPresentationStyle = .fullScreen
        vc.anonimo = chats[indexPath.item].anonimo
        vc.user2UID = users[indexPath.item].id
        vc.user2Name = (users[indexPath.item].firstName ?? "Edward") + " " + (users[indexPath.item].lastName ?? "Pizzurro")
        vc.user2ImgUrl = users[indexPath.item].profilePic
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Firebase -
extension ListaChatsCollectionViewController {
    
    func fetchChats() {
        
        db.collection("Chats").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1").getDocuments { (chats, error) in
            
            if let _ = error {
                print("No hay chats")
            
            } else {
                
                for document in chats!.documents {
                    var chat = Chat(dictionary: document.data())
                    
                    chat?.anonimo = document["anonimo"] as? Bool
                    
                    self.chats.append(chat!)
                }
                
                self.fetchUsers()
            }
        }
        
    }
    
    func fetchUsers() {

        for chat in chats {
            print("feo")
            print(chat.anonimo)
            let userFilterChat = chat.users.filter { user in
                return user != FirebaseAuth.Auth.auth().currentUser?.uid
            }
            
            print("Chao")
            print(userFilterChat[0])
            
            self.db.collection("users").document(userFilterChat[0]).getDocument { (document, error) in
                
                print("algo")
                
                if let document = document {
                    let user = User()
                    user.id = document.documentID
                    
                    if chat.anonimo! {
                        user.firstName = "Anónimo"
                        user.lastName = ""
                        user.profilePic = "https://firebasestorage.googleapis.com/v0/b/metromatch-6771a.appspot.com/o/AnonymousPost.png?alt=media&token=18e5a740-17c3-437f-bf0f-1a40c3746c52"
                    } else {
                        user.firstName = document["firstName"] as? String
                        user.lastName = document["lastName"] as? String
                        user.profilePic = document["profilePic"] as? String
                    }
                    
                    self.users.append(user)
                    print("gaa")
                    print(user.firstName)
                    print(self.users)
                    self.collectionView.reloadData()
                
                } else {
                    print("No existe el usuario")
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    
}
