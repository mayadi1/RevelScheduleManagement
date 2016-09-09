//
//  Employee.swift
//  RevelScheduleManagement
//
//  Created by Keita Ito on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import Foundation

struct Employee {
    let id: Int
    let first_name: String
    let last_name: String
}

func createEmployees(objects objects: [[String : AnyObject]]) -> [Employee]? {
    guard objects.count > 0 else { return nil }
    let works = objects.flatMap { (object) -> Employee? in
        return constructEmployee(object: object)
    }
    return works
}

func constructEmployee(object object: [String : AnyObject]) -> Employee? {
    if let id = object["id"] as? Int,
        let first_name = object["first_name"] as? String,
        let last_name = object["last_name"] as? String {
        let employee = Employee(id: id, first_name: first_name, last_name: last_name)
        return employee
    } else {
        return nil
    }
}