//
//  CollectionViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/22/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


//let posts: [Post] = [
//    Post(imagenPerfil: UIImage(named: "mia") ?? UIImage(), nombre: "Mia Milano", imagenPrincipal: UIImage(named: "george") ?? UIImage(), username: "@miamilano", descripcion: "Me parece muy inteligente y guapo!!!", comentarios: ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]),
//    Post(imagenPerfil: UIImage(named: "stevenn") ?? UIImage(), nombre: "Steven", imagenPrincipal: UIImage(named: "johana") ?? UIImage(), username: "@steven", descripcion: "Johana me parece super mega linda, es mega increible!!!", comentarios: ["@jonathan: si es linda","@juancho: guao quien es esa jeva", "@juancho: guao quien es esa jeva"])
//]

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "Cell"
    let db = Firestore.firestore()
    var usernameString = "@Testing"
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        collectionView.backgroundColor = .white

        collectionView!.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchUsers()
        
    }
    
    func getUsername(crushId: String){
                self.db.collection("users").document(crushId).getDocument{(result, err) in
                    
                    if let result = result, result.exists{
                        self.usernameString = (result["username"] as? String)!
                    } else {
                        print("El usuario no existe")
                    }
                }
    }
    
    func fetchUsers(){
        db.collection("posts").getDocuments(){ [self] (posts, err) in
            if let err = err {
                print("Ocurrio un error", err)
            } else {
                for documentPost in posts!.documents {
                    let crushId = documentPost["crushID"] as? String
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.getUsername(crushId: crushId!)
                        }
                    }

                    let post = Post()
                     
                     post.descripcion = documentPost["description"] as? String
                     post.compatibility = documentPost["compatibility"] as? Int
                     post.comments = ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]
                     post.profilePic = documentPost["profilePic"] as? String
                    post.username = self.usernameString
                    
                    self.posts.append(post)
                }
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                print("testing")
                print(self.posts[0].username)
            }
        }
    }
    
    func fetchPosts(){
        db.collection("posts").getDocuments(){(posts, err) in
            if let err = err {
                print("Fetching failed", err)
            } else {
                for documentPost in posts!.documents {
                    let user = User()
                    let creator = User()
                    let post = Post()
                    user.id = documentPost["crushID"] as? String
                    creator.id = documentPost["creatorID"] as? String
                    
                    
                    self.db.collection("users").document((user.id)!).getDocument{ (documentUser, err) in
                    if let documentUser = documentUser, documentUser.exists {
                        post.username = documentUser["username"] as? String
                        
                    } else {
                        print("El documento no existe")
                    }
                        
                        
                    self.db.collection("users").document((creator.id)!).getDocument{(documentCreator, err) in
                            if let documentCreator = documentCreator, documentCreator.exists{
                                
                                post.creatorProfilePic = documentCreator["profilePic"] as? String
                                post.usernameCreator = documentCreator["username"] as? String
                                print(post.usernameCreator, post.creatorProfilePic)
                            } else {
                                print("El documento no existe")
                            }
                        }
                        
                        
                        post.profilePic = documentPost["profilePic"] as? String
                        post.comments = ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]
                        post.descripcion = documentPost["description"] as? String
                        post.compatibility = documentPost["compatibility"] as? Int
                        self.posts.append(post)
                        print(self.posts)
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                    print(self.posts)
                }
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
        //print(self.posts)
        //cell.imagenPerfil.downloaded(from: posts[indexPath.item].creatorProfilePic!)
        cell.nombreUsuario.text = posts[indexPath.item].username
       cell.imagenGrande.downloaded(from: posts[indexPath.item].profilePic!)
        cell.usuarioLabel.text = posts[indexPath.item].username
        cell.descripcion.text = posts[indexPath.item].descripcion
        
        
       // cell.tableView.numberOfRows(inSection: posts[indexPath.item].comments.count)
        //cell.tableView.cellForRow(at: indexPath)?.textLabel = posts[indexPath.item].comentarios[indexPath.item]
        

    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let aproximateWidthOfBioTextView = view.frame.width - 40
//        let size = CGSize(width: aproximateWidthOfBioTextView, height: 1000)
//        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)]
//
//        let estimatedFrame = NSString(string: posts[indexPath.item].descripcion).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
//
//        return CGSize(width: view.frame.width, height: estimatedFrame.height + 66)
        
        let size = CGSize(width: collectionView.frame.width, height: 500)
        return size
    }
    
    
    
    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

