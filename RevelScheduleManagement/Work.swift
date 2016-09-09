//
//  Work.swift
//  RevelScheduleManagement
//
//  Created by Keita Ito on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import Foundation

struct Work {
    let employee: String
    let id: Int
    let shift_begin_time: String
    let shift_end_time: String
    
    let year: Int
    let month: Int
    let day: Int
    let hour: Int
    let endingHour: Int
    let role: String
    
    var employeeObj: Employee?
}

extension Work: CustomStringConvertible {
    var description: String {
        return employee + "\n" + String(id) + "\n" + shift_begin_time + "\n" + shift_end_time + "\n"
    }
}



struct WorkGenerator {
    
    static func generateWorks(objects objects: [[String : AnyObject]]) -> [Work]? {
        guard objects.count > 0 else { return nil }
        let works = objects.flatMap { (object) -> Work? in
            return generateWork(object: object)
        }
        return works
    }
    
    static func generateWork(object object: [String : AnyObject]) -> Work? {

//        guard let employee = object["employee"] as? String else { return nil }        
//        guard let id = object["id"] as? Int else { return nil }
//        guard let shift_begin_time = object["shift_begin_time"] as? String else { return nil }
//        guard let shift_end_time = object["shift_end_time"] as? String else { return nil }
        
        if let employee = object["employee"] as? String {
            if let id = object["id"] as? Int {
                if let shift_begin_time = object["shift_begin_time"] as? String {
                    if let shift_end_time = object["shift_end_time"] as? String {
                        if let role = object["role"] as? String {
                            
                            // Create date.
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            let date = dateFormatter.dateFromString(shift_begin_time)
                            guard let d = date else { return nil }
                            let calendar = NSCalendar.currentCalendar()
                            let components = calendar.components([.Day , .Month , .Year, .Hour], fromDate: d)
                            
                            let hour = components.hour
                            let year = components.year
                            let month = components.month
                            let day = components.day
                            print(year)
                            print(month)
                            print(day)
                            
                            let date2 = dateFormatter.dateFromString(shift_end_time)
                            guard let d2 = date2 else { return nil }
                            let calendar2 = NSCalendar.currentCalendar()
                            let components2 = calendar2.components([ .Hour], fromDate: d2)
                            
                            let endingHour = components2.hour
                        
                          
                            
                            
                            
                            // Construct Work struct instance.
                            let work = Work(employee: employee, id: id, shift_begin_time: shift_begin_time, shift_end_time: shift_end_time, year: year, month: month, day: day, hour:hour,endingHour:endingHour, role: role, employeeObj: nil)
                            print(work.description)
                            return work
                        }
                    }
                }
            }
        }
        
//        let work = Work(employee: employee, id: id, shift_begin_time: shift_begin_time, shift_end_time: shift_end_time)
//        return work
        return nil
    }
    
    
    
    
    
    ////////
    
    static func schedule_generateWorks(employee employee: Employee, objects: [[String : AnyObject]]) -> [Work]? {
        guard objects.count > 0 else { return nil }
        let works = objects.flatMap { (object) -> Work? in
            return schedule_generateWork(employee: employee, object: object)
        }
        return works
    }
    
    static func schedule_generateWork(employee employeeObj: Employee, object: [String : AnyObject]) -> Work? {
        
        //        guard let employee = object["employee"] as? String else { return nil }
        //        guard let id = object["id"] as? Int else { return nil }
        //        guard let shift_begin_time = object["shift_begin_time"] as? String else { return nil }
        //        guard let shift_end_time = object["shift_end_time"] as? String else { return nil }
        
        if let employee = object["employee"] as? String {
            if let id = object["id"] as? Int {
                if let shift_begin_time = object["shift_begin_time"] as? String {
                    if let shift_end_time = object["shift_end_time"] as? String {
                        if let role = object["role"] as? String {
                            
                            // Create date.
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            let date = dateFormatter.dateFromString(shift_begin_time)
                            guard let d = date else { return nil }
                            let calendar = NSCalendar.currentCalendar()
                            let components = calendar.components([.Day , .Month , .Year, .Hour], fromDate: d)
                            
                            let hour = components.hour
                            let year = components.year
                            let month = components.month
                            let day = components.day
                            print(year)
                            print(month)
                            print(day)
                            
                            let date2 = dateFormatter.dateFromString(shift_end_time)
                            guard let d2 = date2 else { return nil }
                            let calendar2 = NSCalendar.currentCalendar()
                            let components2 = calendar2.components([ .Hour], fromDate: d2)
                            
                            let endingHour = components2.hour
                            
                            
                            
                            
                            
                            // Construct Work struct instance.
                            let work = Work(employee: employee, id: id, shift_begin_time: shift_begin_time, shift_end_time: shift_end_time, year: year, month: month, day: day, hour:hour,endingHour:endingHour, role: role, employeeObj: employeeObj)
                            print(work.description)
                            return work
                        }
                    }
                }
            }
        }
        
        //        let work = Work(employee: employee, id: id, shift_begin_time: shift_begin_time, shift_end_time: shift_end_time)
        //        return work
        return nil
    }
}
