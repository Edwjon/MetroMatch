//
//  PostCell.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/24/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    let viewArriba: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        return view
    }()
    
    
    let imagenPerfil: UIImageView = {
        let imagen = UIImageView()
        //imagen.backgroundColor = .red
        imagen.layer.cornerRadius = 25
        imagen.clipsToBounds = true
        imagen.contentMode = .scaleToFill
        imagen.translatesAutoresizingMaskIntoConstraints = false
        imagen.layer.shadowColor = UIColor.gray.cgColor
        imagen.layer.shadowOpacity = 0.9
        imagen.layer.shadowOffset = CGSize.zero
        imagen.layer.shadowRadius = 6
        imagen.isUserInteractionEnabled = true
        return imagen
    }()
    
    
    let nombreUsuario: UILabel = {
        let label = UILabel()
        label.text = "Usuario"
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .purple
        return label
    }()
    
    let viewCuadrada: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
//        view.layer.shadowColor = UIColor.gray.cgColor
//        view.layer.shadowOpacity = 0.9
//        view.layer.shadowOffset = CGSize.zero
//        view.layer.shadowRadius = 6
        return view
    }()
    
    let separador: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    let imagenGrande: UIImageView = {
        let imagen = UIImageView()
        //imagen.backgroundColor = .green
        imagen.layer.cornerRadius = 10
        imagen.contentMode = .scaleToFill
        imagen.clipsToBounds = true
        imagen.translatesAutoresizingMaskIntoConstraints = false
        return imagen
    }()
    
    let usuarioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    let descripcion: UITextView = {
        let tv = UITextView()
        tv.textColor = .black
        tv.isEditable = false
        tv.backgroundColor = .clear
        //tv.layer.cornerRadius = 10
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isUserInteractionEnabled = false
        //tv.text = "Hola esta es mi descripcion del mensaje jajajajajajjajajajajajjajajajajajjajajajajajjajajajajajjajajajajajjajajajajajjajajajajajjajajajajajjajajajajaj"
        //tv.backgroundColor = .yellow
        return tv
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = false
        tv.delegate = self
        tv.dataSource = self
        tv.layer.cornerRadius = 10
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        return tv
    }()
    
    var boton: UIButton = {
        let boton = UIButton(type: .system)
        //boton.titleLabel?.text = "Match"
        //boton.tintColor = .black
        boton.setTitleColor(.white, for: .normal)
        boton.setTitle("Match", for: .normal)
        boton.backgroundColor = .systemPink
        boton.layer.cornerRadius = 5
        boton.layer.masksToBounds = true
        return boton
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addSubview(viewArriba)
        viewArriba.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 50)
        
        viewArriba.addSubview(imagenPerfil)
        imagenPerfil.anchor(viewArriba.topAnchor, left: viewArriba.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        viewArriba.addSubview(nombreUsuario)
        nombreUsuario.anchor(nil, left: imagenPerfil.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width - 30 - 50 - 30 - 10, heightConstant: 35)
        nombreUsuario.centerYAnchor.constraint(equalTo: imagenPerfil.centerYAnchor, constant: 0).isActive = true
        
        addSubview(viewCuadrada)
        viewCuadrada.anchor(imagenPerfil.bottomAnchor, left: imagenPerfil.leftAnchor, bottom: nil, right: nombreUsuario.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 350)
        viewCuadrada.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        viewCuadrada.addSubview(imagenGrande)
        imagenGrande.anchor(viewCuadrada.topAnchor, left: viewCuadrada.leftAnchor, bottom: nil, right: viewCuadrada.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 200)
        
        viewCuadrada.addSubview(boton)
        boton.anchor(imagenGrande.bottomAnchor, left: nil, bottom: nil, right: imagenGrande.rightAnchor, topConstant: 12, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 100, heightConstant: 30)
        
        viewCuadrada.addSubview(usuarioLabel)
        usuarioLabel.anchor(imagenGrande.bottomAnchor, left: viewCuadrada.leftAnchor, bottom: nil, right: boton.leftAnchor, topConstant: 12, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 30)
        
        viewCuadrada.addSubview(descripcion)
        descripcion.anchor(usuarioLabel.bottomAnchor, left: usuarioLabel.leftAnchor, bottom: nil, right: boton.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        //viewCuadrada.addSubview(tableView)
        //tableView.anchor(descripcion.bottomAnchor, left: descripcion.leftAnchor, bottom: viewCuadrada.bottomAnchor, right: descripcion.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
//        addSubview(separador)
//        separador.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0.5)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        
//        cell.textLabel?.text = posts[indexPath.item].comentarios[indexPath.item]
        return cell
    }
    
}






