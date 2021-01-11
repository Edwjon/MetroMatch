//
//  SurveyCells.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 9/1/21.
//  Copyright © 2021 Edwjon. All rights reserved.
//

import UIKit

class SurveyCell: UICollectionViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return respuestas[self.tag][row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        textField.text = respuestas[self.tag][row]
        answers[self.tag] = row
        textField.resignFirstResponder()
        
        contador = contador + 1
        if contador == 10 {
            enabled = true
        }
        
    }

    let label: UILabel = {
        let label  = UILabel()
        label.textColor = .white
        return label
    }()
    
    var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 12
        return tf
    }()
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let colorIzquierda = UIColor(red: 0.902, green: 0.452, blue: 0.454, alpha: 1)
        let colorDerecha = UIColor(red: 0.914, green: 0.472, blue: 0.651, alpha: 1)
        setGradientBackground(colorOne: colorDerecha, colorTwo: colorIzquierda)
        
        picker.delegate = self
        picker.dataSource = self
        
        textField.inputView = picker
        
        addSubview(textField)
        textField.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 40, rightConstant: 20, widthConstant: 0, heightConstant: 30)
        
        addSubview(label)
        label.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 25, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class FooterSurveyView: UICollectionViewCell {
    
    let boton: UIButton = {
        let boton = UIButton(type: .system)
        boton.setTitle("Done", for: .normal)
        boton.setTitleColor(.white, for: .normal)
        boton.layer.masksToBounds = true
        boton.layer.cornerRadius = 12
        boton.backgroundColor = .systemPink
        let colorIzquierdaAmarillo = UIColor(red: 1, green: 0.73, blue: 0.004, alpha: 1)
        let colorDerechaNaranja = UIColor(red: 0.998, green: 0.417, blue: 0.298, alpha: 1)
        boton.setGradientBackground(colorOne: colorDerechaNaranja, colorTwo: colorIzquierdaAmarillo)
        return boton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(boton)
        boton.anchor(nil, left: nil, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 40)
        boton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
