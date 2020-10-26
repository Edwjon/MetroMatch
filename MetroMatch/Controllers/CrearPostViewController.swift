//
//  CrearPostViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/26/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

class CrearPostViewController: UIViewController {

    @IBOutlet var crearPostLabel: UILabel!
    @IBOutlet var imagenPerfil: UIImageView!
    @IBOutlet var usuarioLabel: UILabel!
    @IBOutlet var descripcionTextView: UITextView!
    @IBOutlet var publicarBoton: UIButton!
    @IBOutlet var vista: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
    }
    
    func setupInterface() {
        let customFont = UIFont(name: "LobsterTwo-Bold", size: UIFont.labelFontSize)
        crearPostLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
        crearPostLabel.textColor = .black
        
        usuarioLabel.textColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        usuarioLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        imagenPerfil.image = UIImage(named: "mia")
        imagenPerfil.layer.cornerRadius = 12
        imagenPerfil.contentMode = .scaleToFill
        
        publicarBoton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont!)
        publicarBoton.layer.masksToBounds = true
        publicarBoton.tintColor = .white
        publicarBoton.layer.cornerRadius = 12
        let colorIzquierda = UIColor(red: 0.902, green: 0.452, blue: 0.454, alpha: 1)
        let colorDerecha = UIColor(red: 0.914, green: 0.472, blue: 0.651, alpha: 1)
        publicarBoton.setGradientBackground(colorOne: colorDerecha, colorTwo: colorIzquierda)
        
        descripcionTextView.backgroundColor = .lightGray
        
        vista.layer.cornerRadius = 12
        vista.layer.borderWidth = 0.5
        vista.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    @IBAction func publicar(_ sender: Any) {
        performSegue(withIdentifier: "publicarSegue", sender: self)
    }
    

}
