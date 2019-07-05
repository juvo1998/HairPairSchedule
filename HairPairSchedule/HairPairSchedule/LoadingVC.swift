//
//  LoadingVC.swift
//  HairPairSchedule
//
//  Created by Justin Vo on 7/2/19.
//  Copyright © 2019 Justin Vo. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Firebase

/*
 Happens between the login and schedule screens. The user will be locked in this screen until all data has
 finished loading into the appointments array.
 */
class LoadingVC: UIViewController {
    
    let times = ["0900", "0930", "1000", "1030", "1100", "1130", "1200", "1230", "1300", "1330", "1400", "1430",
            "1500", "1530", "1600", "1630", "1700", "1730", "1800", "1830", "1900", "1930"]
    
    var firebase: DatabaseReference?
    var user: User?
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoadingVC: viewDidload()")
        
        self.navigationItem.hidesBackButton = true
        
        let activity = UIActivityIndicatorView(style: .gray)
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        activity.startAnimating()
        self.view.addSubview(activity)
        
        // Start loading or creating entries in Firebase
        let date = getDate()
        self.firebase = Database.database().reference()
        self.firebase!.child("schedule").child(date).observeSingleEvent(of: .value) { (snapshot) in
            // First, iterate through the times to see if those times exist
            var counter = snapshot.childrenCount
            for time in self.times {
                
                // If time doesn't exist, create it with empty entries
                if !snapshot.hasChild(time) {
                    print("Setting to firebase")
                    self.firebase!.child("schedule").child(date).child(time).child("name").setValue("a")
                    self.firebase!.child("schedule").child(date).child(time).child("price").setValue(" ")
                    self.firebase!.child("schedule").child(date).child(time).child("details").setValue(" ")
                    print("Fin set")
                    
                    counter = counter + 1
                    print(counter)
                    if counter == self.times.count {
                        print("Finished creating all empty slots")
                        // self.performSegue(withIdentifier: "ScheduleSegue", sender: self)
                    }
                }
            }
        }
        
        // Note that this performSegue() should be only done after the last load of data is finished
        // performSegue(withIdentifier: "ScheduleSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ScheduleSegue":
            let scheduleVC = segue.destination as! ScheduleVC
            scheduleVC.user = self.user
            scheduleVC.appointments = self.appointments
        default:
            print("LoadingVC: default case")
        }
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
    
    func getReadableTime(_ time: String) -> String {
        switch time {
        case "0900":
            return "9:00 AM"
        case "0930":
            return "9:30 AM"
        case "1000":
            return "10:00 AM"
        case "1030":
            return "10:30 AM"
        case "1100":
            return "11:00 AM"
        case "1130":
            return "11:30 AM"
        case "1200":
            return "12:00 PM"
        case "1230":
            return "12:30 PM"
        case "1300" :
            return "1:00 PM"
        case "1330":
            return "1:30 PM"
        case "1400":
            return "2:00 PM"
        case "1430":
            return "2:00 PM"
        case "1500":
            return "3:00 PM"
        case "1530":
            return "3:30 PM"
        case "1600":
            return "4:00 PM"
        case "1630":
            return "4:30 PM"
        case "1700":
            return "5:00 PM"
        case "1730":
            return "5:30 PM"
        case "1800":
            return "6:00 PM"
        case "1830":
            return "6:30 PM"
        case "1900":
            return "7:00 PM"
        case "19:30":
            return "7:30 PM"
        default:
            print("LoadingVC: default")
            return "LoadingVC: default"
        }
    }
}
