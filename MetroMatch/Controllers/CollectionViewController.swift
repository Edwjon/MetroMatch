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
import SDWebImage


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
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc: ViewController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! ViewController

            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
        
        
        
        title = "Posts"
        navigationItem.largeTitleDisplayMode = .always
        collectionView.backgroundColor = .white

        collectionView!.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchUsers()
        
//        self.myGroup.notify(queue: .main) {
//            self.orderPostByDate()
//        }
        
        
        //myPosts(userIdentifier: "3pzblgRpwZQTAooKEjgIQVvWcgA3")
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        collectionView.allowsSelection = false
        
        setupTabBar()
        
    }
    
    
    func setupTabBar(){
        guard let tabbar = self.tabBarController?.tabBar else { return }
        
        let colorIzquierda = UIColor(red: 0.977, green: 0.454, blue: 0.683, alpha: 1)
        let colorDerecha = UIColor(red: 0.970, green: 0.459, blue: 0.461, alpha: 1)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tabbar.bounds
        gradientLayer.colors = [colorIzquierda.cgColor, colorDerecha.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        tabbar.layer.insertSublayer(gradientLayer, at: 0)
        
        tabbar.layer.cornerRadius = 30
        tabbar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabbar.layer.masksToBounds = true
        view.setGradientBackground(colorOne: colorIzquierda, colorTwo: colorDerecha)

    }
    
    
    func getUsername(crushId: String){
        self.db.collection("users").document(crushId).getDocument{(result, err) in
            
            if let result = result, result.exists{
                self.usernameString = (result.data()!["username"] as? String)!
            } else {
                print("El usuario no existe")
            }
        }
    }
    
    func orderPostByDate(){
        self.posts = self.posts.sorted(by: {
            $0.date?.compare($1.date ?? Date()) == .orderedDescending
        })
    }
    
    let myGroup = DispatchGroup()
    
    func fetchUsers(){
        
//        myGroup.enter()
        
        db.collection("posts").getDocuments(){ [self] (posts, err) in
            if let err = err {
                print("Ocurrio un error", err)
//                self.myGroup.leave()
            } else {
                for documentPost in posts!.documents {
                    let anonymousRef = documentPost["anonymous"] as? Bool
                    print("the anonymous is \(anonymousRef)")
                    let crushId = documentPost["crushID"] as? String
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.getUsername(crushId: crushId!)
                        }
                    }

                    let post = Post()
                    let dataRef = documentPost["date"] as? Timestamp
                    let date = Date(timeIntervalSince1970: TimeInterval(dataRef!.seconds))
                    
                    post.date = date
                    post.descripcion = documentPost["description"] as? String
                    post.compatibility = documentPost["compatibility"] as? Int
                    post.comments = ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]
                    post.profilePic = documentPost["profilePic"] as? String
                    
                    //NOS TRAEMOS EL NOMBRE DE USUARIO QUE PUBLICO EL POST
                    
//                    let group = DispatchGroup()
//                    group.enter()
                    
                    self.db.collection("users").document((documentPost["creatorID"] as? String)!).getDocument { (document, error) in
                        if let document = document, document.exists {
                            if(anonymousRef==true){
                                post.usernameCreator = "Post Anónimo"
                                post.creatorProfilePic = "https://firebasestorage.googleapis.com/v0/b/metromatch-6771a.appspot.com/o/AnonymousPost.png?alt=media&token=18e5a740-17c3-437f-bf0f-1a40c3746c52"
                                group.leave()
                            } else {
                                post.usernameCreator = document["username"] as? String
                                post.creatorProfilePic = document["profilePic"] as? String
                                group.leave()
                            }
                        } else {
                            print("Document does not exist")
//                            group.leave()
//                            self.myGroup.leave()
                        }
                    }
                    
//                    group.notify(queue: .main) {
                        self.db.collection("users").document((documentPost["crushID"] as? String)!).getDocument { (document, error) in
                            if let document = document, document.exists {
                                post.username = document["username"] as? String
                                print("Document data: \(document["username"])")
                            } else {
                                print("Document does not exist")
                            }
                        }
                        
                        self.posts.append(post)
                        self.orderPostByDate()
//                    }
                    
                    
                }
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                print("testing")
            }
        }
        
//        self.myGroup.leave()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
        
//        self.myGroup.notify(queue: .main) {
        
        
            cell.nombreUsuario.text = self.posts[indexPath.item].username
            cell.nombreUsuario.text = self.posts[indexPath.item].username
            
            if let imagenProfile = self.posts[indexPath.item].profilePic {
                cell.imagenGrande.downloaded(from: imagenProfile)
            }
            
            if let imagenCreador = self.posts[indexPath.item].creatorProfilePic {
//                cell.imagenPerfil.downloaded(from: imagenCreador)
                SDWebImageManager.shared.loadImage(with: URL(string: imagenCreador), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                    cell.imagenPerfil.image = image
                }
            }
//            cell.imagenGrande.downloaded(from: self.posts[indexPath.item].profilePic!)
//            cell.imagenPerfil.downloaded(from: self.posts[indexPath.item].creatorProfilePic!)
            cell.nombreUsuario.text = self.posts[indexPath.item].usernameCreator
            cell.usuarioLabel.text = self.posts[indexPath.item].username
            cell.descripcion.text = self.posts[indexPath.item].descripcion
            
            if let compatibilidad = self.posts[indexPath.item].compatibility {
                cell.compatibilidadLabel.text = "Compatibilidad: \(compatibilidad)%"
            }
            cell.boton.isHidden = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.goProfile))
            cell.imagenPerfil.addGestureRecognizer(tapGesture)
        
        
//        }
        
       // cell.tableView.numberOfRows(inSection: posts[indexPath.item].comments.count)
        //cell.tableView.cellForRow(at: indexPath)?.textLabel = posts[indexPath.item].comentarios[indexPath.item]
        
        return cell
    }
    
    @objc func goProfile() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dvc: DescriptionViewController = mainStoryboard.instantiateViewController(withIdentifier: "edit") as! DescriptionViewController
        dvc.editable = false
        dvc.idUsuario = 0
        self.present(dvc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.width, height: 500)
        return size
    }
    
    
    @IBAction func messages(_ sender: Any) {
        performSegue(withIdentifier: "mensajes", sender: nil)
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

