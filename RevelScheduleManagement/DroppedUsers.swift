//
//  DroppedUsers.swift
//  RevelScheduleManagement
//
//  Created by Mohamed Ayadi on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class DroppedUsers: NSObject {

    var start: String
    var end: String
    var reason: String
    var id: String
    
    init(tempStart: String, tempEnd: String, tempReason: String, tempID: String){
        
        self.start = tempStart
        self.end = tempEnd
        self.reason = tempReason
        self.id = tempID
    }
    
}

