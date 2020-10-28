//
//  CrearPostViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/26/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CrearPostViewController: UIViewController {

    @IBOutlet var crearPostLabel: UILabel!
    @IBOutlet var imagenPerfil: UIImageView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var descripcionTextView: UITextView!
    @IBOutlet var publicarBoton: UIButton!
    @IBOutlet var vista: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Crear"
        
        setupInterface()
    }
    let db = Firestore.firestore()
    
    func randomCompatibility() -> Int{
        let number = 0 + arc4random_uniform(100 - 0 + 1)
        return Int(number)
    }
    
    func setupInterface() {
        guard let customFont = UIFont(name: "LobsterTwo-Bold", size: UIFont.labelFontSize) else {return}
        crearPostLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        crearPostLabel.textColor = .black
        
        //usuarioLabel.textColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        //usuarioLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        imagenPerfil.image = UIImage(named: "mia")
        imagenPerfil.layer.cornerRadius = 12
        imagenPerfil.contentMode = .scaleToFill
        
        publicarBoton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
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
        var crushID = ""
        guard let username = usernameTextField.text, !username.isEmpty,
              let description = descripcionTextView.text, !description.isEmpty
        else{
            print("Debe llenar todos los campos")
            return
        }
        print(description)
        db.collection("users").whereField("username", isEqualTo: username).getDocuments(){(result, err) in
            if let err = err {
                print("No existe el nombre de usuario ingresado, por favor ingrese un nombre de usuario válido", err)
            } else {
                print("Se obtuvo un resultado")
                for document in result!.documents {
                    crushID = document.documentID
                }
                let compatibility = self.randomCompatibility()
                print(compatibility)
                let user = Auth.auth().currentUser
                if user != nil {
                    let postData: [String: Any] = [
                        "comments": [],
                        "compatibility": compatibility,
                        "creatorID": user!.uid,
                        "crushID": crushID,
                        "description": description,
                        "id": "",
                    ]
                    var ref: DocumentReference? = nil
                    ref = self.db.collection("posts").addDocument(data: postData){ err in
                        if let err = err {
                            print("No se creo el post", err)
                        } else {
                            self.db.collection("posts").document(ref!.documentID).updateData([
                                "id": ref!.documentID,
                            ]){err in
                                if let err = err {
                                    print("El post no se creo correctamente", err)
                                } else {
                                    print("El post se creo correctamente")
                                }
                            }
                            
                        }
                    }
                } else {
                  print("No se ha iniciado sesión")
                }
            }
        }
        self.crearTabBar()
        //performSegue(withIdentifier: "publicarSegue", sender: self)
    }
    

}
