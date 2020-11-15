//
//  MyProfile.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 11/5/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

class MyProfile: UITableViewController {
    
    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var postsButton: UIButton!
    @IBOutlet var notificationButton: UIButton!
    @IBOutlet var mentionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
