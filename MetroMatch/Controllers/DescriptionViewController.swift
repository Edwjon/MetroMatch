//
//  DescriptionViewController.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/24/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var profileBackgroundImage: UIImageView!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ProfileCell2.self, forCellReuseIdentifier: "cell2")
        tableView.register(ProfileCell3.self, forCellReuseIdentifier: "cell3")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 170
        
        setupInterface()
    }
    
    
    func setupInterface() {
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.contentMode = .scaleToFill
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
            return cell
        }
        
        if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ProfileCell2
            return cell
        }
        
        if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! ProfileCell3
            return cell
        }

        return UITableViewCell()
    }

}
