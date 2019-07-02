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

class LoadingVC: UIViewController {
    
    var user: User?
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoadingVC: viewDidload()")
        
        let appt = Appointment(time: "9:45 AM", date: "asdf", name: "ASDF", price: 20.05, details: "asdf")
        self.appointments.append(appt)
        performSegue(withIdentifier: "ScheduleSegue", sender: self)
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
}
