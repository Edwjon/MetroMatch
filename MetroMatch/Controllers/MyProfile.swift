//
//  MyProfile.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/5/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MyProfile: UITableViewController, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300), collectionViewLayout: UICollectionViewFlowLayout())
        return cv
    }()
    
    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var postsButton: UIButton!
    @IBOutlet var matchesButton: UIButton!
    @IBOutlet var mentionButton: UIButton!
    
    //1: Posts
    //2: Matches
    //3: Mentions
    
    var selectedMenu = 1
    let reuseIdentifier = "Cell"
    let db = Firestore.firestore()
    var posts = [Post]()
    var user = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedMenu = 1
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId2")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId3")
        
        user = Auth.auth().addStateDidChangeListener { (auth, users) in
            print(users)
        } as! User
    
    }
    
    func myPosts(userIdentifier:String) {
        //LA SIGUIENTE LINEA ES COMO SE HACE QUERIES ESPECIFICOS EN FIREBASE
        db.collection("posts").whereField("creatorID", isEqualTo: userIdentifier)
            .getDocuments() { (documentPosts, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for post in documentPosts!.documents {
                        print("llego la data")
                        print("\(post.documentID) => \(post.data())")
                        
                        let myPost = Post()
                        myPost.profilePic = post["profilePic"] as! String
                        myPost.descripcion = post["description"] as? String
                        myPost.compatibility = post["compatibility"] as? Int
                        myPost.comments = ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]
                        myPost.username = "Yo"
                        myPost.creatorProfilePic = ""
                        self.posts.append(myPost)
                    }
                    var index = 0
                    while index < 5 {
                        print("viendo si en verdad se guardaron en posts ")
                        print(self.posts[index].username)
                        print(self.posts[index].profilePic)
                        print(self.posts[index].descripcion)
                        print(self.posts[index].comments)
                        print(self.posts[index].creatorProfilePic)
                        index = index + 1
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedMenu == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            cell.backgroundColor = .red
            cell.textLabel?.text = "Posts"
            return cell
        
        } else if selectedMenu == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId2", for: indexPath)
            cell.backgroundColor = .blue
            cell.textLabel?.text = "Matches"
            return cell
        
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId3", for: indexPath)
            cell.backgroundColor = .yellow
            cell.textLabel?.text = "Menciones"
            return cell
        }
    }
    

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
    @IBAction func posts(_ sender: Any) {
        selectedMenu = 1
        tableView.reloadData()
    }
    
    @IBAction func matches(_ sender: Any) {
        selectedMenu = 2
        tableView.reloadData()
    }
    
    @IBAction func mentions(_ sender: Any) {
        selectedMenu = 3
        tableView.reloadData()
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dvc: DescriptionViewController = mainStoryboard.instantiateViewController(withIdentifier: "edit") as! DescriptionViewController
        dvc.editable = true
        dvc.idUsuario = 0
        self.present(dvc, animated: true, completion: nil)
    }
    
}
