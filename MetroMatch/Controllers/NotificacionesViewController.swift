//
//  NotificacionesViewController.swift
//
//
//  Created by Edward Pizzurro Fortun on 11/4/20.
//

import UIKit


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
    
    @IBOutlet var notificacionesButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: "cellId")
        notificacionesButton.isUserInteractionEnabled = false
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! NotificationCell
        cell.backgroundColor = .cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 74)
    }
    
    
    @IBAction func notificaciones(_ sender: Any) {
        //tableView.reloadData()
    }
}
