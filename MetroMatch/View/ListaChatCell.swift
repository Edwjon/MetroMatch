//
//  ListaChatCell.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 9/1/21.
//  Copyright © 2021 Edwjon. All rights reserved.
//

import UIKit

class ListaChatsCell: UICollectionViewCell {
    
    let imagenPerfil: UIImageView = {
        let imagen = UIImageView()
        imagen.layer.cornerRadius = imagen.bounds.size.width / 2.0
        imagen.layer.masksToBounds = true
        roundingUIView(let: imagen, let: 30)
        return imagen
    }()
    
    let nombreUsuario: UITextView = {
        let label = UITextView()
        label.text = "hola"
        label.isEditable = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemPink
        label.isUserInteractionEnabled = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imagenPerfil)
        imagenPerfil.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 70, heightConstant: 70)
        
        addSubview(nombreUsuario)
        nombreUsuario.anchor(topAnchor, left: imagenPerfil.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 24, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 35)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
