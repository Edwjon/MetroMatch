//
//  CollectionViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/22/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

let posts: [Post] = [
    Post(imagenPerfil: UIImage(named: "mia") ?? UIImage(), nombre: "Mia Milano", imagenPrincipal: UIImage(named: "george") ?? UIImage(), username: "@miamilano", descripcion: "Me parece muy inteligente y guapo!!!", comentarios: ["@andrea: Sii me parece lindísimo","@valeria: Sii guao me parece muy lindo", "@juancho: guao quien es esa jeva"]),
    Post(imagenPerfil: UIImage(named: "stevenn") ?? UIImage(), nombre: "Steven", imagenPrincipal: UIImage(named: "johana") ?? UIImage(), username: "@steven", descripcion: "Johana me parece super mega linda, es mega increible!!!", comentarios: ["@jonathan: si es linda","@juancho: guao quien es esa jeva", "@juancho: guao quien es esa jeva"])
]

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "Cell"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        collectionView.backgroundColor = .white

        collectionView!.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
    
        cell.imagenPerfil.image = posts[indexPath.item].imagenPerfil
        cell.nombreUsuario.text = posts[indexPath.item].nombre
        cell.imagenGrande.image = posts[indexPath.item].imagenPrincipal
        cell.usuarioLabel.text = posts[indexPath.item].username
        cell.descripcion.text = posts[indexPath.item].descripcion
        
        //cell.tableView.numberOfRows(inSection: posts[indexPath.item].comentarios.count)
//        cell.tableView.cellForRow(at: indexPath)?.textLabel = posts[indexPath.item].comentarios[indexPath.item]
        

    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let aproximateWidthOfBioTextView = view.frame.width - 40
//        let size = CGSize(width: aproximateWidthOfBioTextView, height: 1000)
//        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)]
//
//        let estimatedFrame = NSString(string: posts[indexPath.item].descripcion).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
//
//        return CGSize(width: view.frame.width, height: estimatedFrame.height + 66)
        
        let size = CGSize(width: collectionView.frame.width, height: 500)
        return size
    }
    
    
    
    

}

