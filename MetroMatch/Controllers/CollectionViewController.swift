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


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "Cell"
    let db = Firestore.firestore()
    var usernameString = "@Testing"
    var posts = [Post]()
    let myGroup = DispatchGroup()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        fetchUsers()
        setupTabBar()
    }
}


//MARK: - CollectionView -
extension CollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
        
        
        cell.nombreUsuario.text = self.posts[indexPath.item].username
        cell.nombreUsuario.text = self.posts[indexPath.item].username
        cell.imagenGrande.downloaded(from: self.posts[indexPath.item].profilePic!)
        
        if let imagen = self.posts[indexPath.item].creatorProfilePic {
            cell.imagenPerfil.downloaded(from: imagen)
        }
        
        cell.nombreUsuario.text = self.posts[indexPath.item].usernameCreator
        cell.usuarioLabel.text = self.posts[indexPath.item].username
        cell.descripcion.text = self.posts[indexPath.item].descripcion
        
        if let compatibilidad = self.posts[indexPath.item].compatibility {
            cell.compatibilidadLabel.text = "Compatibilidad: \(compatibilidad)%"
        }
        
        cell.boton.isHidden = true
            
        let tapGestureCreator = CustomTapGestureRecognizer(target: self, action: #selector(goProfile(sender:)))
        tapGestureCreator.id = posts[indexPath.item].creatorID
        cell.imagenPerfil.addGestureRecognizer(tapGestureCreator)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.width, height: 500)
        return size
    }
}


// MARK: - Setup -
extension CollectionViewController {
    
    func setupInterface() {
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! LoginViewController

            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
        
        title = "Posts"
        navigationItem.largeTitleDisplayMode = .always
        collectionView.backgroundColor = .white

        collectionView!.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        collectionView.allowsSelection = false
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
}


// MARK: - Actions -
extension CollectionViewController {
    
    class CustomTapGestureRecognizer: UITapGestureRecognizer {
          var id: String?
    }
    
    @objc func goProfile(sender: CustomTapGestureRecognizer) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dvc: DescriptionViewController = mainStoryboard.instantiateViewController(withIdentifier: "edit") as! DescriptionViewController
        dvc.editable = false
        
        //NOS TRAEMOS EL USUARIO
        
        dvc.idUsuario = sender.id!
        self.present(dvc, animated: true, completion: nil)
    }
    
    
    @IBAction func messages(_ sender: Any) {
        performSegue(withIdentifier: "mensajes", sender: nil)
    }
    
}


// MARK: - Firebase -
extension CollectionViewController {
    
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
    
    
    
    func fetchUsers(){
        
        db.collection("posts").addSnapshotListener{(postsRef, err) in
            guard let posts = postsRef?.documents else {
                print("Error fetching posts")
                return
            }
            self.posts=[]
            for documentPost in posts {
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
                post.creatorID = documentPost["creatorID"] as? String
                post.descripcion = documentPost["description"] as? String
                post.compatibility = documentPost["compatibility"] as? Int
                post.comments = ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]
                post.profilePic = documentPost["profilePic"] as? String
                
                //NOS TRAEMOS EL NOMBRE DE USUARIO QUE PUBLICO EL POST
                self.db.collection("users").document((documentPost["creatorID"] as? String)!).getDocument { (document, error) in
                    if let document = document, document.exists {
                        if(anonymousRef==true){
                            post.usernameCreator = "Post Anónimo"
                            post.creatorID = "lM30eN2SozK6CzQ2M1S4"
                            post.creatorProfilePic = "https://firebasestorage.googleapis.com/v0/b/metromatch-6771a.appspot.com/o/AnonymousPost.png?alt=media&token=18e5a740-17c3-437f-bf0f-1a40c3746c52"
                        } else {
                            post.usernameCreator = document["username"] as? String
                            post.creatorProfilePic = document["profilePic"] as? String
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
                
                    self.db.collection("users").document((documentPost["crushID"] as? String)!).getDocument { (document, error) in
                        if let document = document, document.exists {
                            post.username = document["username"] as? String
                            post.profilePic = document["profilePic"] as? String
                            print("Document data: \(document["username"])")
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                    self.posts.append(post)
                    self.orderPostByDate()
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}
