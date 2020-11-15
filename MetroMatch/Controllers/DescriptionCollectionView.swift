//
//  DescriptionCollectionView.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/15/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit


class HeaderView: UICollectionViewCell {
    
    var imagenPerfil: UIImageView = {
        let imagen = UIImageView()
        imagen.backgroundColor = .cyan
        imagen.translatesAutoresizingMaskIntoConstraints = false
        imagen.layer.cornerRadius = imagen.frame.width / 2
        imagen.clipsToBounds = true
        return imagen
    }()
    
    var userLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    var postButton: UIButton = {
        let boton = UIButton(type: .system)
        boton.titleLabel?.text = "Posts"
        boton.titleLabel?.textColor = .white
        boton.backgroundColor = .systemPink
        return boton
    }()
    
    var matchesButton: UIButton = {
        let boton = UIButton(type: .system)
        boton.titleLabel?.text = "Matches"
        boton.titleLabel?.textColor = .white
        boton.backgroundColor = .green
        return boton
    }()
    
    var mentionsButton: UIButton = {
        let boton = UIButton(type: .system)
        boton.titleLabel?.text = "Mentions"
        boton.titleLabel?.textColor = .white
        boton.backgroundColor = .purple
        return boton
    }()
    
    var updateButton: UIButton = {
        let boton = UIButton(type: .custom)
        boton.titleLabel?.text = "Update"
        boton.titleLabel?.textColor = .white
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class Matches: UICollectionViewCell{
    
    var imagenUsuario: UIImageView = {
        let imagen = UIImageView()
        imagen.backgroundColor = .cyan
        imagen.layer.cornerRadius = imagen.frame.width / 2
        imagen.clipsToBounds = true
        return imagen
    }()
    
    var usuarioLabel: UILabel = {
        let label = UILabel()
        label.text = "@Edwjon"
        return label
    }()
    
    var matchLabel: UILabel = {
        let label = UILabel()
        label.text = "Hiciste Match"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imagenUsuario)
        imagenUsuario.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        addSubview(usuarioLabel)
        usuarioLabel.anchor(imagenUsuario.topAnchor, left: imagenUsuario.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        addSubview(matchLabel)
        matchLabel.anchor(usuarioLabel.bottomAnchor, left: imagenUsuario.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 6, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class DescriptionCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var selectedMenu = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        collectionView.backgroundColor = .white

        collectionView!.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
        collectionView!.register(Matches.self, forCellWithReuseIdentifier: "matchesCell")
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "mentionsCell")
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
            
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
            
        collectionView.allowsSelection = false
            
    }
        
        
    @objc func funcionMensajes() {
        print("qlq")
    }
        

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
                    
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        if selectedMenu == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
            
            cell.nombreUsuario.text = "Hola"
            cell.imagenGrande.downloaded(from: "https://firebasestorage.googleapis.com/v0/b/metromatch-6771a.appspot.com/o/IMG_8386.png?alt=media&token=942c020a-d0b9-4d93-b5fc-2ef1f4459596")
            cell.imagenPerfil.downloaded(from: "https://firebasestorage.googleapis.com/v0/b/metromatch-6771a.appspot.com/o/IMG_8386.png?alt=media&token=942c020a-d0b9-4d93-b5fc-2ef1f4459596")
            cell.usuarioLabel.text = "HOla"
            cell.descripcion.text = "Descripcion"
            cell.boton.isHidden = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goProfile))
            cell.imagenPerfil.addGestureRecognizer(tapGesture)
                
            return cell
        
        } else if selectedMenu == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchesCell", for: indexPath) as! Matches
            cell.backgroundColor = .red
            return cell
        
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mentionsCell", for: indexPath)
            cell.backgroundColor = .yellow
                
            return cell
        }
        
    }
        
    @objc func goProfile() {
            
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dvc: DescriptionViewController = mainStoryboard.instantiateViewController(withIdentifier: "edit") as! DescriptionViewController
        dvc.editable = false
        dvc.idUsuario = 0
        self.present(dvc, animated: true, completion: nil)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = CGSize(width: collectionView.frame.width, height: 200)
        
        if selectedMenu == 1 {
            size = CGSize(width: collectionView.frame.width, height: 500)
        }
        
        if selectedMenu == 2 {
            size = CGSize(width: collectionView.frame.width, height: 60)
        }
        
        if selectedMenu == 3 {
            size = CGSize(width: collectionView.frame.width, height: 200)
        }
        
        collectionView.reloadData()
        
        return size
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderView
        header.postButton.addTarget(self, action: #selector(posts), for: .touchUpInside)
        header.matchesButton.addTarget(self, action: #selector(matches), for: .touchUpInside)
        header.mentionsButton.addTarget(self, action: #selector(mentions), for: .touchUpInside)
        header.updateButton.addTarget(self, action: #selector(goProfile), for: .touchUpInside)
        return header
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

