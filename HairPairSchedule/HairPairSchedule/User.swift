//
//  User.swift
//  HairPairSchedule
//
//  Created by Justin Vo on 6/20/19.
//  Copyright © 2019 Justin Vo. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    var id: Int?
    var name: String
    var username: String
    var password: String
    
    // Used for signing up, the id will be created by count of users
    init(name: String, username: String, password: String) {
        self.name = name
        self.username = username
        self.password = password
        self.id = getUniqueId()
    }
    
    init(id: Int, name: String, username: String, password: String) {
        self.id = id
        self.name = name
        self.username = username
        self.password = password
    }
    
    private func getUniqueId() -> Int {
        // TODO: finish
        return -1
    }
}
