//
//  ScheduleTableVC.swift
//  HairPairSchedule
//
//  Created by Justin Vo on 6/22/19.
//  Copyright © 2019 Justin Vo. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Firebase

class ScheduleTableVC: UITableViewController {
    
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ScheduleTableVC: viewDidLoad()")
        
        // Remove the lines of empty cells
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = 180.0
        
        let appt = Appointment(time: "9:45 AM", date: "asdf", name: "ASDF", price: 20.05, details: "asdf")
        self.appointments.append(appt)
        print("a")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScheduleCell
        let appointment = self.appointments[indexPath.row]
        
        cell.time.text = appointment.time
        cell.name.text = appointment.name
        cell.price.text = "$\(appointment.price)"
        // TODO: cell.details.text = appointment.details
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointments.count
    }
}
