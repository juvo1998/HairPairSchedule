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

class ScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate, AppointmentsReference {
    
    var user: User?
    var appointments: [Appointment]?
    var selectedAppt: Appointment?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            // self.tableView.rowHeight = UITableView.automaticDimension
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
        cell.details.text = appointment.details
        
        // If the price is 0 (empty entry), then just display nothing for the price
        if appointment.price == 0.0 {
            cell.price.text = ""
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            let priceStr = formatter.string(from: NSNumber(value: appointment.price))
            cell.price.text = priceStr
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func setAppointments(newAppointments: [Appointment]) {
        self.appointments = newAppointments
        self.tableView.reloadData()
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.selectedAppt = self.appointments![indexPath.row]
        performSegue(withIdentifier: "AppointmentSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AppointmentSegue":
            let appointmentVC = segue.destination as! AppointmentVC
            appointmentVC.appointment = self.selectedAppt
            appointmentVC.appointments = self.appointments
            appointmentVC.appointmentsDelegate = self
        default:
            print("ScheduleVC: default")
        }
    }
}
