//
//  MatchTestingViewController.swift
//  MetroMatch
//
//  Created by Luis Fernando Manzano on 10/31/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

//import UIKit
//import Firebase
//
//let db = Firestore.firestore()
//
//func matchMaker(postId:String){
//   var thirsty:String = ""
//   var crush: String = ""
//    
//    let post = db.collection("posts").document(postId)
//
//    post.getDocument { (document, error) in
//        if let document = document, document.exists {
//            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//            //print("Document data: \(dataDescription)")
//             thirsty = (document.data()!["creatorID"] as? String)!
//            print("thirsty \(thirsty)")
//             crush = (document.data()!["crushID"] as? String)!
//            print("crush \(crush)")
//        } else {
//            print("Document does not exist")
//        }
//    }
//    
//    print("crush222 \(crush)")
//    
//    let myData: [String: Any] = [
//        "id": "",
//        "postID": postId,
//        "state": 1,
//        "thirstyID": thirsty,
//        "crushID": crush
//    ]
//    print(myData)
//    var ref: DocumentReference? = nil
//    
//    ref = db.collection("matches").addDocument(data: myData){ err in
//        if let err = err {
//            print("No se creo el match", err)
//        } else {
//            db.collection("matches").document(ref!.documentID).updateData([
//                "id": ref!.documentID,
//                "crushID": crush,
//                "thirstyID": thirsty
//            ]){err in
//                if let err = err {
//                    print("Match Fallido", err)
//                } else {
//                    print("Haz hecho match!!")
//                }
//            }
//            
//        }
//    }
//    
//    
//    
//}
//
//func undoMatch (matchID:String) {
//    let post = db.collection("matches").document(matchID)
//
//            db.collection("matches").document(matchID).updateData([
//                "state": 0
//            ]){err in
//                if let err = err {
//                    print("No se pudo deshacer tu match", err)
//                } else {
//                    print("Haz roto un corazon satisfactoriamente")
//                }
//            }
//            
//        }
//    
//
//class MatchTestingViewController: UIViewController {
//    
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    
//    @IBAction func MatchButton(_ sender: Any) {
//        matchMaker(postId: "F3cJIbZgKIGgpoisTZCG")
//        
//    }
//    
//    @IBAction func UndoMatch(_ sender: Any) {
//        undoMatch(matchID: "2zvfy4QZxArfFPJREnzO")
//    }
//    
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
