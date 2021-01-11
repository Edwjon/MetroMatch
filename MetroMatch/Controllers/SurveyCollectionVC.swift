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
    ["Si", "No", "", ""],
    ["Equipación deportiva para un día de aventura", "Ropa nueva y a ser posible sexy", "Un buen libro", "Comida de sobra por si alguien tiene hambre"]
]

var numeros = [1,2,3,4,5,6,7,8,9,10]
var answers = [0,0,0,0,0,0,0,0,0,0]
var contador = 0
var enabled = false


class SurveyCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
     
    }
}


// MARK: - Setup -
extension SurveyCollectionVC {
    
    func setupInterface() {
        title = "Encuesta"
        collectionView.backgroundColor = .white
        self.collectionView!.register(SurveyCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(FooterSurveyView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
    }
}


// MARK: - Action -
extension SurveyCollectionVC {
    
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
                }
            }
        
        } else {
            let actionSheet = UIAlertController(title: "Error", message: "Por favor llena todos los campos", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(actionSheet, animated: true, completion: nil)
        }
        
    }
}



// MARK: - CollectionView -
extension SurveyCollectionVC {
    
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
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! FooterSurveyView
        footer.boton.addTarget(self, action: #selector(doneButton), for: .touchUpInside)
        return footer
    }
}
