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
    
    var user: User?
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoadingVC: viewDidload()")
        
        self.navigationItem.hidesBackButton = true
        
        let activityIN = UIActivityIndicatorView(style: .gray)
        activityIN.center = self.view.center
        activityIN.hidesWhenStopped = true
        activityIN.startAnimating()
        self.view.addSubview(activityIN)
        // self.view.bringto
        
        let appt = Appointment(time: "9:45 AM", date: "asdf", name: "ASDF", price: 20.05, details: "Hair cut yay")
        self.appointments.append(appt)
        
        // Note that this performSegue() should be only done after the last load of data is finished
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
