//
//  SurveyCollectionVC.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/26/20.
//  Copyright ©️ 2020 Edwjon. All rights reserved.
//
import UIKit
import Firebase

private let reuseIdentifier = "Cell"

var qlq = false

var preguntas = [
    "Te sientes especial cuando...",
    "¿Dónde preferirías unas vacaciones?",
    "¿Qué sabor de helado prefieres?",
    "¿Qué bebida prefieres?",
    "En una cita, ¿qué prefieres comer?",
    "Mi cita perfecta sería...",
    "Te consideras un persona...",
    "Lo que mas te atrae de una persona es...",
    "¿Crees en el amor a primera vista?",
    "Algo que siempre tienes contigo es..."
]

var respuestas = [
    ["Valoran tus actos", "Los demás te dicen que eres único/a", "Reconocen tu inteligencia", "Hacen lo que tu deseas"],
    ["Europa", "Asia", "Estados Unidos", "El Caribe"],
    ["Chocolate", "Vainilla", "Fresa", "Oreo"],
    ["Merengadas", "Jugos", "Refrescos", "Alcohol"],
    ["Hamburguesa", "Pizza", "Sushi", "Pasta"],
    ["Salir de fiesta a bailar y a tomar", "Salir a tomar un café y hablar de la vida", "Ir al cine", "Pedir comida a domicilio y maratón de series"],
    ["Sociable", "Racional y Calculadora", "Extrovertida", "Introvertida"],
    ["Su bondad", "Su inteligencia", "Su sentido del humor", "Su atractivo físico"],
    ["Si", "No", "a", "a"],
    ["Equipación deportiva para un día de aventura", "Ropa nueva y a ser posible sexy", "Un buen libro", "Comida de sobra por si alguien tiene hambre"]
]

var numeros = [1,2,3,4,5,6,7,8,9,10]

var answers = [0,0,0,0,0,0,0,0,0,0]

var contador = 0
var enabled = false


class FooterView: UICollectionViewCell {
    
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


class SurveyCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Encuesta"
        collectionView.backgroundColor = .white
        self.collectionView!.register(SurveyCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
     
    }
    
    @objc func doneButton() {
        if enabled {
            var ref: DocumentReference? = nil
            ref = self.db.collection("surveys").addDocument(data: [
                "answers": answers,
                "userId": FirebaseAuth.Auth.auth().currentUser!.uid
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    
                    qlq = true
                    self.dismiss(animated: true, completion: nil)
                    //self.performSegue(withIdentifier: "tabbarSurvey", sender: self)
//                    let layout = UICollectionViewFlowLayout()
//                    let vc = SurveyCollectionVC(collectionViewLayout: layout)
//                    let nav = UINavigationController(rootViewController: vc)
//                    nav.modalPresentationStyle = .fullScreen
//                    self.present(vc, animated: true) {
//                        vc.performSegue(withIdentifier: "tabBarRegistrar", sender: self)
//                    }
//                    self.present(nav, animated: true, completion: nil)
                }
            }
        
        } else {
            let actionSheet = UIAlertController(title: "Error", message: "Por favor llena todos los campos", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(actionSheet, animated: true, completion: nil)
        }
        
        //dismiss(animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SurveyCell
        cell.label.text = "\(numeros[indexPath.item]). \(preguntas[indexPath.item])"
        cell.tag = numeros[indexPath.item] - 1
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.frame.width, height: 150)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! FooterView
        footer.boton.addTarget(self, action: #selector(doneButton), for: .touchUpInside)
        return footer
    }
    

}


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
        tf.font = UIFont.systemFont(ofSize: 12) //Aqui va el font del usernameTextfield
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
