//
//  NotificacionesViewController.swift
//
//
//  Created by Edward Pizzurro Fortun on 11/4/20.
//

import UIKit

class NotificacionesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var notificacionesButton: UIButton!
    
    @IBOutlet var mencionesButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    private var selectedMenu: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedMenu = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId2")
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedMenu == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            cell.backgroundColor = .red
            cell.textLabel?.text = "Notificaciones"
            return cell
        
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId2", for: indexPath)
            cell.backgroundColor = .blue
            cell.textLabel?.text = "Menciones"
            return cell
        }
        
    }
    
    
    
    @IBAction func notificaciones(_ sender: Any) {
        selectedMenu = true
        tableView.reloadData()
    }
    
    @IBAction func menciones(_ sender: Any) {
        selectedMenu = false
        tableView.reloadData()
    }
    
    
    
    
}
