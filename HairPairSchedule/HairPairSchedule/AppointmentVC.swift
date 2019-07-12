//
//  AppointmentVC.swift
//  HairPairSchedule
//
//  Created by Justin Vo on 7/6/19.
//  Copyright © 2019 Justin Vo. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Firebase

protocol AppointmentsReference {
    func setAppointments(newAppointments: [Appointment])
}

class AppointmentVC: UIViewController {
    
    var appointmentsDelegate: AppointmentsReference?
    var appointment: Appointment?
    var appointments: [Appointment]?
    var firebase: DatabaseReference?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AppointmentVC: viewDidLoad()")
        
        // Set the data from appointment
        self.navigationItem.title = self.appointment!.time
        self.nameField.text = self.appointment!.name
        self.detailsField.text = self.appointment!.details
        
        // Display the price nicely
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        let price = self.appointment!.price
        let priceStr = formatter.string(from: NSNumber(value: price))
        self.priceField.text = priceStr
        
        self.firebase = Database.database().reference()
    }
    
    @IBAction func apply(_ sender: UIBarButtonItem) {
        // Present a loading screen alert
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let activity = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        activity.style = .gray
        activity.startAnimating()
        alert.view.addSubview(activity)
        present(alert, animated: true)
        
        // Commit the changes to Firebase
        let date = getDate()
        let time = getCompactTime(self.appointment!.time)
        
        // Pull data from text fields
        let newName = self.nameField.text!
        let priceStr = self.priceField.text!
        let newPrice = Double(priceStr)
        let newDetails = self.detailsField.text!
        
        // Send text field data to Firebase (updating)
        self.firebase?.child("schedule").child(date).child(time).child("name").setValue(newName)
        self.firebase?.child("schedule").child(date).child(time).child("price").setValue(newPrice)
        self.firebase?.child("schedule").child(date).child(time).child("details").setValue(newDetails)
        
        // Iterate through appointments list to find the selected appointment
        for appt in self.appointments! {
            if appt.time == self.appointment!.time {
                // Update the appointment in the list
                appt.name = newName
                appt.price = newPrice!
                appt.details = newDetails
            }
        }
        
        self.appointmentsDelegate!.setAppointments(newAppointments: self.appointments!)
        alert.dismiss(animated: false) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        self.nameField.text = ""
        self.priceField.text = "0.00"
        self.detailsField.text = ""
    }
    
    func getDate() -> String {
        // get the current date and time
        let currentDateTime = Date()
        
        // get the user's calendar
        let userCalendar = Calendar.current
        
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
        ]
        
        // get the components
        let date = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        let month = formatter.string(from: NSNumber(value: date.month!))
        let day = formatter.string(from: NSNumber(value: date.day!))
        let year = String(date.year!)
        
        var dateString = ""
        if let monthStr = month {
            if let dayStr = day {
                dateString = "\(monthStr)\(dayStr)\(year)"
            }
        }
        return dateString
    }
    
    func getCompactTime(_ time: String) -> String {
        switch time {
        case "9:00 AM":
            return "0900"
        case "9:30 AM":
            return "0930"
        case "10:00 AM":
            return "1000"
        case "10:30 AM":
            return "1030"
        case "11:00 AM":
            return "1100"
        case "11:30 AM":
            return "1130"
        case "12:00 PM":
            return "1200"
        case "12:30 PM":
            return "1230"
        case "1:00 PM":
            return "1300"
        case "1:30 PM":
            return "1330"
        case "2:00 PM":
            return "1400"
        case "2:30 PM":
            return "1430"
        case "3:00 PM":
            return "1500"
        case "3:30 PM":
            return "1530"
        case "4:00 PM":
            return "1600"
        case "4:30 PM":
            return "1630"
        case "5:00 PM":
            return "1700"
        case "5:30 PM":
            return "1730"
        case "6:00 PM":
            return "1800"
        case "6:30 PM":
            return "1830"
        case "7:00 PM":
            return "1900"
        case "7:30 PM":
            return "1930"
        default:
            print("AppointmentVC: default")
            return "AppointmentVC: default"
        }
    }
}
