//
//  ScheduleVC.swift
//  HairPairSchedule
//
//  Created by Justin Vo on 6/20/19.
//  Copyright © 2019 Justin Vo. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Firebase

class ScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user: User?
    var appointments: [Appointment]?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            print("set del")
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.rowHeight = 180.0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ScheduleVC: viewDidLoad()")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointments!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScheduleCell
        let appointment = self.appointments![indexPath.row]
        
        cell.time.text = appointment.time
        cell.name.text = appointment.name
        cell.price.text = "$\(appointment.price)"
        // TODO: cell.details.text = appointment.details
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
