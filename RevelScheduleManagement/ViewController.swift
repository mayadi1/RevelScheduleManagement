//
//  ViewController.swift
//  RevelScheduleManagement
//
//  Created by Mohamed Ayadi on 9/8/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CLWeeklyCalendarViewDelegate {
    
    var calendarView = CLWeeklyCalendarView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = CGRectMake(0, 0, view.bounds.size.width, 130)
        calendarView = CLWeeklyCalendarView(frame: frame)
        calendarView.backgroundColor = UIColor.blueColor()
        calendarView.delegate = self
        self.view.addSubview(self.calendarView)
        
        let request = NSURLRequest(URL: oneEmployeeShiftURL)
        let session = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                print(data)
                if let data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                        print(json)
                        if let jsonDict = json as? NSDictionary {
                            if let objects = jsonDict["objects"] as? [[String : AnyObject]] {
                                print(objects)
                                print(objects[0])
                                let works = WorkGenerator.generateWorks(objects: objects)
                            }
                        }
                        
                        
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                }
            }
        }
        session.resume()
        
        
        
    }
    
    func CLCalendarBehaviorAttributes() -> [NSObject : AnyObject]! {
        return [CLCalendarWeekStartDay : 2]
    }
    
    func dailyCalendarViewDidSelect(date: NSDate!) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



