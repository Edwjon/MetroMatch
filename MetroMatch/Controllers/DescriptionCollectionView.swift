//
//  DescriptionCollectionView.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/15/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class HeaderView: UICollectionViewCell {
    
    var imagenPerfil: UIImageView = {
        let imagen = UIImageView()
        imagen.translatesAutoresizingMaskIntoConstraints = false
        imagen.layer.cornerRadius = imagen.frame.width / 2
        imagen.clipsToBounds = true
        imagen.isUserInteractionEnabled = true
        return imagen
    }()
    
    var userLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var postButton: UIButton = {
        let boton = UIButton(type: .system)
        boton.setTitle("My Posts", for: .normal)
        boton.setTitleColor(.white, for: .normal)
        boton.backgroundColor = .systemPink
        return boton
    }()
    
    var matchesButton: UIButton = {
        let boton = UIButton(type: .system)
        boton.setTitle("Matches", for: .normal)
        boton.setTitleColor(.white, for: .normal)
        boton.backgroundColor = .systemPink
        return boton
    }()
    
    var mentionsButton: UIButton = {
        let boton = UIButton(type: .system)
        boton.setTitle("Mentions", for: .normal)
        boton.setTitleColor(.white, for: .normal)
        boton.backgroundColor = .systemPink
        return boton
    }()
    
    
    var updateButton: UIButton = {
        let boton = UIButton(type: .custom)
        boton.setTitle("Update", for: .normal)
        boton.setTitleColor(.white, for: .normal)
        boton.backgroundColor = .orange
        return boton
    }()
    
    var logOutButton: UIButton = {
        let boton = UIButton(type: .custom)
        boton.setTitle("Log Out", for: .normal)
        boton.setTitleColor(.white, for: .normal)
        boton.backgroundColor = .orange
        return boton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imagenPerfil)
        imagenPerfil.anchor(topAnchor, left: nil, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 150)
        imagenPerfil.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(userLabel)
        userLabel.anchor(imagenPerfil.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        userLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(matchesButton)
        matchesButton.anchor(userLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 138, heightConstant: 40)
        matchesButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(postButton)
        postButton.anchor(userLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 138, heightConstant: 40)
        
        addSubview(mentionsButton)
        mentionsButton.anchor(userLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 138, heightConstant: 40)
        
        addSubview(updateButton)
        updateButton.anchor(imagenPerfil.topAnchor, left: imagenPerfil.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 6, bottomConstant: 0, rightConstant: 6, widthConstant: 0, heightConstant: 40)
        
        addSubview(logOutButton)
        logOutButton.anchor(updateButton.bottomAnchor, left: imagenPerfil.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 6, bottomConstant: 0, rightConstant: 6, widthConstant: 0, heightConstant: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class Matches: UICollectionViewCell{
    
    var imagenUsuario: UIImageView = {
        let imagen = UIImageView()
        //imagen.backgroundColor = .cyan
        imagen.layer.cornerRadius = imagen.frame.width / 2
        imagen.layer.masksToBounds = true
        return imagen
    }()
    
    var usuarioLabel: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .cyan
        //label.text = "@Edwjon"
        return tv
    }()
    
    var matchLabel: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .orange
        tv.text = "Hiciste Match"
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imagenUsuario)
        imagenUsuario.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        addSubview(usuarioLabel)
        usuarioLabel.anchor(imagenUsuario.topAnchor, left: imagenUsuario.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 30)
        
        addSubview(matchLabel)
        matchLabel.anchor(usuarioLabel.bottomAnchor, left: imagenUsuario.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 6, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class DescriptionCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var selectedMenu = 1
    let db = Firestore.firestore()
    var userPosts = [Post]()
    var userMentions = [Post]()
    var loggedUser = User()
    var myMatches = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        collectionView.backgroundColor = .white

        collectionView!.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
        collectionView!.register(Matches.self, forCellWithReuseIdentifier: "matchesCell")
        collectionView!.register(PostCell.self, forCellWithReuseIdentifier: "mentionsCell")
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
            
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
            
        collectionView.allowsSelection = false
        
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let usuario = user else { return }
            self.myPosts(userIdentifier: usuario.uid)
            self.myMentions(userIdentifier: usuario.uid)
            self.fetchMyMatches(userIdentifier: usuario.uid)
            self.db.collection("users").document((usuario.uid)).getDocument{(documentCreator, err) in
                    if let documentCreator = documentCreator, documentCreator.exists{
                        self.loggedUser.firstName = documentCreator["firstName"] as? String
                        self.loggedUser.lastName = documentCreator["lastName"] as? String
                        self.loggedUser.profilePic = documentCreator["profilePic"] as? String
                    } else {
                        print("El documento no existe")
                    }
                }
        }
            
    }
    
    func fetchMyMatches(userIdentifier:String) {
        db.collection("matches").whereField("crushID", isEqualTo: userIdentifier)
            .getDocuments() { (documentMatches, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for match in documentMatches!.documents {
                        print("llego la data")
                        let myMatch = Match()
                        let crush = User()
                        crush.id = match["thirstyID"] as? String
                        
                        self.db.collection("users").document((crush.id)!).getDocument{ (documentUser, err) in
                        if let documentUser = documentUser, documentUser.exists {
                            myMatch.crushUsername = documentUser["username"] as? String
                            myMatch.crushProfilePic = documentUser["profilePic"] as? String
                        } else {
                            print("El documento no existe")
                        }
                        }
                        myMatch.id = match["id"] as? String
                        myMatch.postID = match["postID"] as? String
                        myMatch.state = match["state"] as? Int
                        self.myMatches.append(myMatch)
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
        }
        
        db.collection("matches").whereField("thirstyID", isEqualTo: userIdentifier)
            .getDocuments() { (documentMatches, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for match in documentMatches!.documents {
                        print("llego la data")
                        let myMatch = Match()
                        let crush = User()
                        crush.id = match["crushID"] as? String
                        
                        self.db.collection("users").document((crush.id)!).getDocument{ (documentUser, err) in
                        if let documentUser = documentUser, documentUser.exists {
                            myMatch.crushUsername = documentUser["username"] as? String
                            myMatch.crushProfilePic = documentUser["profilePic"] as? String
                        } else {
                            print("El documento no existe")
                        }
                        }
                        myMatch.id = match["id"] as? String
                        myMatch.postID = match["postID"] as? String
                        myMatch.state = match["state"] as? Int
                        self.myMatches.append(myMatch)
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
        }
    }
    
    func myMentions(userIdentifier:String) {
        db.collection("posts").whereField("crushID", isEqualTo: userIdentifier)
            .getDocuments() { (documentPosts, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for post in documentPosts!.documents {
                        print("llego la data")
                        print("\(post.documentID) => \(post.data())")
                        let myPost = Post()
                        let user = User()
                        let creator = User()
                        user.id = post["crushID"] as? String
                        creator.id = post["creatorID"] as? String
                        
                        self.db.collection("users").document((user.id)!).getDocument{ (documentUser, err) in
                        if let documentUser = documentUser, documentUser.exists {
                            myPost.username = documentUser["username"] as? String
                            myPost.profilePic = documentUser["profilePic"] as? String
                        } else {
                            print("El documento no existe")
                        }
                        }
                        
                        self.db.collection("users").document((creator.id)!).getDocument{(documentCreator, err) in
                                if let documentCreator = documentCreator, documentCreator.exists{
                                    
                                    myPost.creatorProfilePic = documentCreator["profilePic"] as? String
                                    myPost.usernameCreator = documentCreator["username"] as? String
                                } else {
                                    print("El documento no existe")
                                }
                            }
                        myPost.profilePic = post["profilePic"] as? String
                        myPost.descripcion = post["description"] as? String
                        myPost.id = post["id"] as? String
                        myPost.matched = post["matched"] as? Bool
                        myPost.compatibility = post["compatibility"] as? Int
                        myPost.comments = ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]
                        self.userMentions.append(myPost)
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
        }
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
                        let user = User()
                        let creator = User()
                        user.id = post["crushID"] as? String
                        creator.id = post["creatorID"] as? String
                        
                        self.db.collection("users").document((user.id)!).getDocument{ (documentUser, err) in
                        if let documentUser = documentUser, documentUser.exists {
                            myPost.username = documentUser["username"] as? String
                            myPost.profilePic = documentUser["profilePic"] as? String
                        } else {
                            print("El documento no existe")
                        }
                        }
                        
                        self.db.collection("users").document((creator.id)!).getDocument{(documentCreator, err) in
                                if let documentCreator = documentCreator, documentCreator.exists{
                                    
                                    myPost.creatorProfilePic = documentCreator["profilePic"] as? String
                                    myPost.usernameCreator = documentCreator["username"] as? String
                                } else {
                                    print("El documento no existe")
                                }
                            }
                        myPost.profilePic = post["profilePic"] as? String
                        myPost.descripcion = post["description"] as? String
                        myPost.id = post["id"] as? String
                        myPost.matched = post["matched"] as? Bool
                        myPost.compatibility = post["compatibility"] as? Int
                        myPost.comments = ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]
                        self.userPosts.append(myPost)
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
        }
    }
        
        
    @objc func funcionMensajes() {
        print("qlq")
    }
        

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        if selectedMenu == 1 {
            return userPosts.count
        } else if selectedMenu == 2 {
            return myMatches.count
        } else if selectedMenu == 3 {
            return userMentions.count
        } else {
           return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        if selectedMenu == 1 {
            if (userMentions.count == 0){
                print("No tienes Posts")
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mentionsCell", for: indexPath) as! PostCell
                return cell
            } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
            
            cell.nombreUsuario.text = userPosts[indexPath.item].usernameCreator
            cell.imagenGrande.downloaded(from: userPosts[indexPath.item].profilePic ?? "")
            cell.imagenPerfil.downloaded(from:userPosts[indexPath.item].creatorProfilePic ?? "")
            cell.usuarioLabel.text = userPosts[indexPath.item].username
            cell.descripcion.text = userPosts[indexPath.item].descripcion
            cell.boton.isHidden = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goProfile))
            cell.imagenPerfil.addGestureRecognizer(tapGesture)
                
            return cell
            }
        }
        
        else if selectedMenu == 2 {
            
//            if (userMentions.count == 0){
//                print("No tienes Matches")
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchesCell", for: indexPath) as! Matches
//                return cell
//            } else if (myMatches[indexPath.item].state == 0){
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchesCell", for: indexPath) as! Matches
//                return cell
//            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchesCell", for: indexPath) as! Matches
                cell.backgroundColor = .red
                cell.imagenUsuario.downloaded(from: myMatches[indexPath.item].crushProfilePic ?? "")
                cell.usuarioLabel.text = myMatches[indexPath.item].crushUsername
                return cell
            //}
        
        }
        
        else {
            if (userMentions.count == 0){
                print("No tienes Menciones")
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mentionsCell", for: indexPath) as! PostCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mentionsCell", for: indexPath) as! PostCell
                
                cell.nombreUsuario.text = userMentions[indexPath.item].usernameCreator
                cell.imagenGrande.downloaded(from: userMentions[indexPath.item].creatorProfilePic ?? "")
                cell.imagenPerfil.downloaded(from:userMentions[indexPath.item].profilePic ?? "")
                cell.usuarioLabel.text = userMentions[indexPath.item].username
                cell.descripcion.text = userMentions[indexPath.item].descripcion
                
                if !(userMentions[indexPath.item].matched!) {
                    cell.boton.setTitle("Unmatch", for: .normal)
                } else {
                    cell.boton.setTitle("Match", for: .normal)
                }
                
                cell.boton.isHidden = false
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goProfile))
                cell.imagenPerfil.addGestureRecognizer(tapGesture)
                
                
                let tapGestureMatch = CustomTapGestureRecognizer(target: self, action: #selector(doMatch(sender:)))
                tapGestureMatch.postId = userMentions[indexPath.item].id
                tapGestureMatch.matched = (userMentions[indexPath.item].matched!) as Bool
                tapGestureMatch.index = indexPath.item
                cell.boton.addGestureRecognizer(tapGestureMatch)
                return cell
            }
        }
        
    }
    
    class CustomTapGestureRecognizer: UITapGestureRecognizer {
        var postId: String?
        var matched: Bool?
        var index: Int?
    }
    
    @objc func doMatch(sender: CustomTapGestureRecognizer){
        if(sender.matched!){
            print("undoMatch")
            undoMatch(postId: sender.postId ?? "")
            self.userMentions[sender.index ?? 0].matched = false
            self.collectionView.reloadData()
        } else {
            print("doMatch")
            matchMaker(postId: sender.postId ?? "")
            self.userMentions[sender.index ?? 0].matched = true
//            DispatchQueue.global(qos: .userInitiated).async {
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            }
            self.collectionView.reloadData()
        }
    }
    
    func matchMaker(postId:String){
       var thirsty:String = ""
       var crush: String = ""
        
        self.db.collection("posts").document(postId ?? "").updateData([
                    "matched": true
                ]){err in
                    if let err = err {
                        print("No se actualizo el post", err)
                    } else {
                        print("Se actualizo el post")
                    }
                }
        
        db.collection("matches").whereField("postID", isEqualTo: postId)
            .getDocuments() { (matches, err) in
                if let err = err {
                    let post = self.db.collection("posts").document(postId)
                    
                    post.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            //print("Document data: \(dataDescription)")
                             thirsty = (document.data()!["creatorID"] as? String)!
                            print("thirsty \(thirsty)")
                             crush = (document.data()!["crushID"] as? String)!
                            print("crush \(crush)")
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                    print("crush222 \(crush)")
                    
                    let myData: [String: Any] = [
                        "id": "",
                        "postID": postId,
                        "state": 1,
                        "thirstyID": thirsty,
                        "crushID": crush
                    ]
                    print(myData)
                    var ref: DocumentReference? = nil
                    
                    ref = self.db.collection("matches").addDocument(data: myData){ err in
                        if let err = err {
                            print("No se creo el match", err)
                        } else {
                            self.db.collection("matches").document(ref!.documentID).updateData([
                                "id": ref!.documentID,
                                "crushID": crush,
                                "thirstyID": thirsty
                            ]){err in
                                if let err = err {
                                    print("Match Fallido", err)
                                } else {
                                    print("Haz hecho match!!")
                                }
                            }
                            
                        }
                    }
                } else {
                    for match in matches!.documents {
                        let matchId = match.data()["id"] as? String

                        self.db.collection("matches").document(matchId ?? "").updateData([
                                    "state": 1
                                ]){err in
                                    if let err = err {
                                        print("No se pudo deshacer tu match", err)
                                    } else {
                                        print("Se volvio a hacer match")
                                    }
                                }
                    }
                }
        }
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func undoMatch (postId:String) {
        self.db.collection("posts").document(postId ?? "").updateData([
                    "matched": false
                ]){err in
                    if let err = err {
                        print("No se actualizo el post", err)
                    } else {
                        print("Se actualizo el post")
                    }
                }
        self.db.collection("matches").whereField("postID", isEqualTo: postId)
            .getDocuments() { (matches, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for match in matches!.documents {
                        let matchId = match.data()["id"] as? String

                        self.db.collection("matches").document(matchId ?? "").updateData([
                                    "state": 0
                                ]){err in
                                    if let err = err {
                                        print("No se pudo deshacer tu match", err)
                                    } else {
                                        print("Haz roto un corazon satisfactoriamente")
                                    }
                                }
                    }
                }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    @objc func goProfile() {
            
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dvc: OwnProfileVC = mainStoryboard.instantiateViewController(withIdentifier: "ownProfile") as! OwnProfileVC
        //dvc.editable = false
        //dvc.idUsuario = 0
        self.present(dvc, animated: true, completion: nil)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if selectedMenu == 1 {
            return CGSize(width: collectionView.frame.width, height: 450)
        }
        
        else if selectedMenu == 2 {
            return CGSize(width: collectionView.frame.width, height: 100)
        }
        
        else {
            return CGSize(width: collectionView.frame.width, height: 450)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderView
        header.postButton.addTarget(self, action: #selector(posts), for: .touchUpInside)
        header.matchesButton.addTarget(self, action: #selector(matches), for: .touchUpInside)
        header.mentionsButton.addTarget(self, action: #selector(mentions), for: .touchUpInside)
        header.updateButton.addTarget(self, action: #selector(goProfile), for: .touchUpInside)
        header.logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        header.imagenPerfil.downloaded(from: self.loggedUser.profilePic ?? "")
        header.userLabel.text = (self.loggedUser.firstName ?? "Nombre") + " " + (self.loggedUser.lastName ?? "Apellido")
        
        
        return header
    }
    
    @objc func logOut() {
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Seguro que desea hacer Log Out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { [weak self] _ in
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                //self?.navigationController?.pushViewController(vc, animated: true)
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc: ViewController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! ViewController
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            } catch {
                print("Error")
            }
        }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func posts() {
        selectedMenu = 1
        collectionView.reloadData()
    }
    
    @objc func matches() {
        selectedMenu = 2
        collectionView.reloadData()
    }
    
    @objc func mentions() {
        selectedMenu = 3
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 300)
    }
    
}



