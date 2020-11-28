//
//  NotificacionesViewController.swift
//
//
//  Created by Edward Pizzurro Fortun on 11/4/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class NotificationCell: UICollectionViewCell {
    
    var imagen: UIImageView = {
        let imagen = UIImageView()
        imagen.backgroundColor = .orange
        return imagen
    }()
    
    var mensaje: UITextView = {
        let tv = UITextView()
        tv.text = "Ok amigo comi estas"
        //label.numberOfLines = 0
        tv.backgroundColor = .purple
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imagen)
        imagen.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        addSubview(mensaje)
        mensaje.anchor(topAnchor, left: imagen.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 12, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class NotificacionesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let db = Firestore.firestore()
    var notis = [Noti]()
    
    
    @IBOutlet var notificacionesButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: "cellId")
        notificacionesButton.isUserInteractionEnabled = false
        myNotis(userIdentifier: "3pzblgRpwZQTAooKEjgIQVvWcgA3")
    }
    
    func myNotis(userIdentifier:String) {
        //LA SIGUIENTE LINEA ES COMO SE HACE QUERIES ESPECIFICOS EN FIREBASE
        db.collection("notifications").whereField("toUser", isEqualTo: userIdentifier)
            .getDocuments() { (documentPosts, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for noti in documentPosts!.documents {
                        print("llego la data")
                        print("\(noti.documentID) => \(noti.data())")
                        
                        let myNoti = Noti()
                        myNoti.message = noti.data()["message"] as! String
                        
                        
                        self.notis.append(myNoti)
                    }
                    var index = 0
//                    while index == 0 {
//                        print("viendo si en verdad se guardaron en posts ")
//                        print(self.notis[index].message)
//                        index = index + 1
//                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! NotificationCell
        cell.backgroundColor = .cyan
        cell.mensaje.text = notis[indexPath.item].message
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 74)
    }
    
    
    @IBAction func notificaciones(_ sender: Any) {
        //tableView.reloadData()
    }
}
