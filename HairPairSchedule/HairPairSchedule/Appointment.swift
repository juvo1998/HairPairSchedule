//
//  Appointment.swift
//  HairPairSchedule
//
//  Created by Justin Vo on 6/22/19.
//  Copyright © 2019 Justin Vo. All rights reserved.
//

import Foundation
import Firebase

class Appointment {
    
    var time: String
    var date: String
    var name: String
    var price: Double
    var details: String
    
    init(time: String, date: String, name: String, price: Double, details: String) {
        self.time = time
        self.date = date
        self.name = name
        self.price = price
        self.details = details
    }
}
