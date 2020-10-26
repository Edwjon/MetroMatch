//
//  ProfileCell.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/24/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    let miHistoria: UILabel = {
        let label = UILabel()
        label.text = "Mi historia"
        return label
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let descripcion: UITextView = {
        let tv = UITextView()
        tv.text = "Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui."
        tv.isEditable = false
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        
        addSubview(miHistoria)
        miHistoria.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 50)
        
        addSubview(separatorLine)
        separatorLine.anchor(miHistoria.bottomAnchor, left: miHistoria.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 1)
        
        addSubview(descripcion)
        descripcion.anchor(separatorLine.topAnchor, left: separatorLine.leftAnchor, bottom: nil, right: separatorLine.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ProfileCell2: UITableViewCell {
    
    let misHobbies: UILabel = {
        let label = UILabel()
        label.text = "Mis hobbies"
        return label
    }()
    
    let separatorLine2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let hobbies: UITextView = {
        let tv = UITextView()
        tv.text = "Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui."
        tv.isEditable = false
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell2")
        
        addSubview(misHobbies)
        misHobbies.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 50)
        
        addSubview(separatorLine2)
        separatorLine2.anchor(misHobbies.bottomAnchor, left: misHobbies.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 1)
        
        addSubview(hobbies)
        hobbies.anchor(separatorLine2.topAnchor, left: separatorLine2.leftAnchor, bottom: nil, right: separatorLine2.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class ProfileCell3: UITableViewCell {
    
    let buscando: UILabel = {
        let label = UILabel()
        label.text = "Que estoy buscando"
        return label
    }()
    
    let separatorLine3: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let queBusco: UITextView = {
        let tv = UITextView()
        tv.text = "Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui. Algo para poenr aqui."
        tv.isEditable = false
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell3")
        
        addSubview(buscando)
        buscando.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 250, heightConstant: 50)
        
        addSubview(separatorLine3)
        separatorLine3.anchor(buscando.bottomAnchor, left: buscando.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 1)
        
        addSubview(queBusco)
        queBusco.anchor(separatorLine3.topAnchor, left: separatorLine3.leftAnchor, bottom: nil, right: separatorLine3.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
