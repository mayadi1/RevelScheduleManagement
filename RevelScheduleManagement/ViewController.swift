//
//  ViewController.swift
//  RevelScheduleManagement
//
//  Created by Mohamed Ayadi on 9/8/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CLWeeklyCalendarViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var calendarView = CLWeeklyCalendarView()
    
    @IBOutlet weak var tableView: UITableView!
    
    var worksDate = [Work]()
    var works = [Work]()
    
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
                                self.works = WorkGenerator.generateWorks(objects: objects)!
                                
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
        self.worksDate.removeAll()
        self.tableView.reloadData()

        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        print(year)
        print(month)
        print(day)

        for work in works{
            
            if work.year == year && work.day == day && work.month == month{
                print(" YEs I work this day ok")
                print(work.year)
                self.worksDate.append(work)
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    

    //TableView Setup
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! TableViewCell
        
        
        cell.backgroundColor = UIColor.greenColor()
        
        let tempWork = worksDate[indexPath.row]
        cell.startDate.text = String(tempWork.year)
        cell.endDate.text = "2AM"
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "Drop")!)
    
        return cell
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.worksDate.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let alertController = UIAlertController(title: nil, message: "Drop a shift?", preferredStyle: .Alert)
        
        
        alertController.addTextFieldWithConfigurationHandler({ (textField : UITextField!) -> Void in
            textField.placeholder = "Explain.."
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (UIAlertAction) in
                    tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        }
        
        let dropAction = UIAlertAction(title: "Drop", style: .Default) { (UIAlertAction) in
           
            self.view.endEditing(true)
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(dropAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

