//
//  MyProfile.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/5/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

class MyProfile: UITableViewController, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300), collectionViewLayout: UICollectionViewFlowLayout())
        return cv
    }()
    
    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var postsButton: UIButton!
    @IBOutlet var matchesButton: UIButton!
    @IBOutlet var mentionButton: UIButton!
    
    //1: Posts
    //2: Matches
    //3: Mentions
    
    var selectedMenu = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedMenu = 1
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId2")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId3")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedMenu == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            cell.backgroundColor = .red
            cell.textLabel?.text = "Posts"
            return cell
        
        } else if selectedMenu == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId2", for: indexPath)
            cell.backgroundColor = .blue
            cell.textLabel?.text = "Matches"
            return cell
        
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId3", for: indexPath)
            cell.backgroundColor = .yellow
            cell.textLabel?.text = "Mentions"
            return cell
        }
    }
    

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
    @IBAction func posts(_ sender: Any) {
        selectedMenu = 1
        tableView.reloadData()
    }
    
    @IBAction func matches(_ sender: Any) {
        selectedMenu = 2
        tableView.reloadData()
    }
    
    @IBAction func mentions(_ sender: Any) {
        selectedMenu = 3
        tableView.reloadData()
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dvc: DescriptionViewController = mainStoryboard.instantiateViewController(withIdentifier: "edit") as! DescriptionViewController
        dvc.editable = true
        dvc.idUsuario = 0
        self.present(dvc, animated: true, completion: nil)
    }
    
}
