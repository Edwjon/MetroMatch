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

    @IBOutlet weak var selectUserHandler: UIButton!
    @IBOutlet var crearPostLabel: UILabel!
    @IBOutlet var imagenPerfil: UIImageView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var descripcionTextView: UITextView!
    @IBOutlet var publicarBoton: UIButton!
    @IBOutlet var vista: UIView!
    var labelText: String!
    
    @IBOutlet var anonimoSwitch: UISwitch!
    @IBOutlet var anonimoLabel: UILabel!
    var surveyUser = Survey()
    var surveyCrush = Survey()
    var compatibilityTotal: Int = 0
    var anonymous=false
    
    var nombreTextField = ""
    var imagenDePerfil = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Crear"
        
        usernameTextField.text = nombreTextField
        imagenPerfil.downloaded(from:imagenDePerfil)
        
        anonimoLabel.text = "Público"
        setupInterface()
        //self.usernameTextField.text = self.labelText
        
        
    }
    let db = Firestore.firestore()
    
    func randomCompatibility() -> Int{
        let number = 0 + arc4random_uniform(100 - 0 + 1)
        return Int(number)
    }
    
    func didUserPressTheCellWith( text: String)
        {
        
        usernameTextField.text = text
        }
    
    func setupInterface() {
        guard let customFont = UIFont(name: "LobsterTwo-Bold", size: UIFont.labelFontSize) else {return}
        crearPostLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        crearPostLabel.textColor = .black
    
        //usuarioLabel.textColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        //usuarioLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        //imagenPerfil.image = UIImage(named: "mia")
        imagenPerfil.layer.cornerRadius = 12
        imagenPerfil.contentMode = .scaleToFill
        
        publicarBoton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
        publicarBoton.layer.masksToBounds = true
        publicarBoton.tintColor = .white
        publicarBoton.layer.cornerRadius = 12
        let colorIzquierda = UIColor(red: 0.902, green: 0.452, blue: 0.454, alpha: 1)
        let colorDerecha = UIColor(red: 0.914, green: 0.472, blue: 0.651, alpha: 1)
        publicarBoton.setGradientBackground(colorOne: colorDerecha, colorTwo: colorIzquierda)
        
        descripcionTextView.backgroundColor = UIColor(red: 248/255, green: 150/255, blue: 166/255, alpha: 1)
        descripcionTextView.layer.cornerRadius = 5
        descripcionTextView.layer.masksToBounds = true
        
        vista.layer.cornerRadius = 12
        vista.layer.borderWidth = 0.5
        vista.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func setCompability(userSurvey: [Int], crushSurvey:[Int]){
        var compability: Double = 0
        
        for (index, answer) in userSurvey.enumerated(){
            if(answer == crushSurvey[index]){
                compability=compability+1
            }
            //Prengunta 1
            else if(index==0){
                if (answer==0){
                    
                    if(crushSurvey[0] == 1) {
                        compability=compability+0.25
                    } else if(crushSurvey[0] == 2) {
                        compability=compability+0.50
                    } else if(crushSurvey[0] == 3){
                        compability=compability+0
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[0] == 2) {
                        compability=compability+0.25
                    } else if(crushSurvey[0] == 3) {
                        compability=compability+0.50
                    }
                    
                } else if (answer==2){
                        compability=compability+0.25
                } else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0.25
                    }
                }
            }
            //Fin Pregunta 1

            //Pregunta 2
            else if(index==1){
                if (answer==0){
                    if(crushSurvey[index] == 1) {
                        compability=compability+0.25
                    } else if(crushSurvey[index] == 2) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 3){
                        compability=compability+0.25
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[index] == 2) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 3) {
                        compability=compability+0
                    }
                    
                } else if (answer==2){
                        compability=compability+0.50
                } else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0.25
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0.50
                    }
                }
            }
            //Fin Pregunta 2
            
            //Pregunta 3
            else if(index==2){
                if (answer==0){
                    if(crushSurvey[index] == 1) {
                        compability=compability+0.25
                    } else if(crushSurvey[index] == 2) {
                        compability=compability+0.25
                    } else if(crushSurvey[index] == 3){
                        compability=compability+0.80
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[index] == 2) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 3) {
                        compability=compability+0.25
                    }
                    
                } else if (answer==2){
                    compability=compability+0.3
                } else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0.80
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0.25
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0
                    }
                }

            }
            //Fin Pregunta 3
            
            //Pregunta 4
            else if(index==3){
                if (answer==0){
                    if(crushSurvey[index] == 1) {
                        compability=compability+0.10
                    } else if(crushSurvey[index] == 2) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 3){
                        compability=compability+0
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[index] == 2) {
                        compability=compability+0.10
                    } else if(crushSurvey[index] == 3) {
                        compability=compability+0
                    }
                    
                } else if (answer==2){
                        compability=compability+0.20
                } else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0.10
                    }
                }

            }
            //Fin Pregunta 4
            
            //Pregunta 5
            else if(index==4){
                if (answer==0){
                    if(crushSurvey[index] == 1) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 2) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 3){
                        compability=compability+0.25
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[index] == 2) {
                        compability=compability+0.10
                    } else if(crushSurvey[index] == 3) {
                        compability=compability+0.50
                    }
                    
                } else if (answer==2){
                        compability=compability+0.20
                } else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0.25
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0.20
                    }
                }
            }
            //Fin Pregunta 5
            
            //Pregunta 6
            else if(index==5){
                if (answer==0){
                    if(crushSurvey[index] == 1) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 2) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 3){
                        compability=compability+0
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[index] == 2) {
                        compability=compability+0.30
                    } else if(crushSurvey[index] == 3) {
                        compability=compability+0.70
                    }
                    
                } else if (answer==2){
                        compability=compability+0.50
                } else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0.70
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0.50
                    }
                }
            }
            //Fin Pregunta 6
            
            //Pregunta 7
            else if(index==6){
                if (answer==0){
                    if(crushSurvey[index] == 1) {
                        compability=compability+0.10
                    } else if(crushSurvey[index] == 2) {
                        compability=compability+0.15
                    } else if(crushSurvey[index] == 3){
                        compability=compability+0.70
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[index] == 2) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 3) {
                        compability=compability+0.50
                    }
                    
                } else if (answer==2){
                        compability=compability+0.70
                } else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0.70
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0.70
                    }
                }
            }
            //Fin Pregunta 7
            
            //Pregunta 8
            else if(index==7){
                if (answer==0){
                    if(crushSurvey[index] == 1) {
                        compability=compability+0.25
                    } else if(crushSurvey[index] == 2) {
                        compability=compability+0.10
                    } else if(crushSurvey[index] == 3){
                        compability=compability+0
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[index] == 2) {
                        compability=compability+0.20
                    } else if(crushSurvey[index] == 3) {
                        compability=compability+0.10
                    }
                    
                } else if (answer==2){
                        compability=compability+0
                }else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0.10
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0
                    }
                }
            }
            //Fin Pregunta 8
            
            //Pregunta 9
            else if(index==8){
                compability=compability+0
            }
            //Fin Pregunta 9
            
            //Pregunta 10
            else if(index==9){
                if (answer==0){
                    if(crushSurvey[index] == 1) {
                        compability=compability+0.10
                    } else if(crushSurvey[index] == 2) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 3){
                        compability=compability+0.50
                    }
                    
                } else if (answer==1){
                    
                    if(crushSurvey[index] == 2) {
                        compability=compability+0.10
                    } else if(crushSurvey[index] == 3) {
                        compability=compability+0
                    }
                    
                } else if (answer==2){
                        compability=compability+0.25
                } else if (answer==3){
                    if(crushSurvey[index] == 0) {
                        compability=compability+0.50
                    } else if(crushSurvey[index] == 1) {
                        compability=compability+0
                    } else if(crushSurvey[index] == 2){
                        compability=compability+0.25
                    }
                }
            }
            //Fin Pregunta 10
        }
        self.compatibilityTotal=Int(compability*10)
        print("The compatibility is \(self.compatibilityTotal)")
    }
    
    func fetchSurveys(userId:String, crushId: String){
        self.myGroup.enter()
        self.db.collection("surveys").whereField("userId", isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.surveyUser.answers = document["answers"] as? [Int]
                        self.surveyUser.userId = userId as? String
                        self.surveyUser.id = document.documentID as? String
                    }
                    print("the creator survey is \(self.surveyUser.answers)")
                    self.db.collection("surveys").whereField("userId", isEqualTo: crushId)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for documentCrush in querySnapshot!.documents {
                                    self.surveyCrush.answers = documentCrush["answers"] as? [Int]
                                    self.surveyCrush.userId = crushId as? String
                                    self.surveyCrush.id = documentCrush.documentID as? String
                                }
                                print("the crush survey is \(self.surveyCrush.answers)")
                                self.setCompability(userSurvey: self.surveyUser.answers ?? [], crushSurvey: self.surveyCrush.answers ?? [])
                                self.myGroup.leave()
                                
                            }
                    }
                }
        }
        
        
        
    }
    
    let myGroup = DispatchGroup()
    
    @IBAction func publicar(_ sender: Any) {
        var crushID = ""
        var profilePic = ""
        let user = Auth.auth().currentUser
        if(user==nil){
            return print("Usuario no loggeado")
        }
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
                    profilePic = (document["profilePic"] as? String)!
                }
                
                //aqui
                self.fetchSurveys(userId: user!.uid, crushId: crushID)
                
                self.myGroup.notify(queue: .main) {
                    if user != nil {
                        let postData: [String: Any] = [
                            "comments": [],
                            "compatibility": self.compatibilityTotal,
                            "creatorID": user!.uid,
                            "crushID": crushID,
                            "description": description,
                            "id": "",
                            "profilePic": profilePic,
                            "matched": false,
                            "anonymous": self.anonymous
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
                                        
                                        self.performSegue(withIdentifier: "aaaa", sender: self)
                                    }
                                }
                                
                            }
                        }
                    } else {
                      print("No se ha iniciado sesión")
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func openSelectUser(_ sender: Any) {
        let selectUserController = SelectUserController()
        let navController = UINavigationController(rootViewController: selectUserController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func cambioSwitch(_ sender: Any) {
        if !anonimoSwitch.isOn {
            anonimoLabel.text = "Anónimo"
            self.anonymous=true
        } else {
            anonimoLabel.text = "Público"
            self.anonymous=false
        }
    }
    
}
