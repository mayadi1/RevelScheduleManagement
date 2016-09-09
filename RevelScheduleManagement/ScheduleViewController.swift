//
//  ScheduleViewController.swift
//  RevelScheduleManagement
//
//  Created by Keita Ito on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLWeeklyCalendarViewDelegate {
    
    var allWorks = [Work]()
    var worksDate = [Work]()
    var employees = [Employee]()
    
    var calendarView = CLWeeklyCalendarView()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        setupCalendarView()
        getWorkSchedule()
    }
    
    private func setupCalendarView() {
        let frame = CGRectMake(0, 0, view.bounds.size.width, 130)
        calendarView = CLWeeklyCalendarView(frame: frame)
        calendarView.backgroundColor = UIColor.blueColor()
        calendarView.delegate = self
        self.view.addSubview(self.calendarView)
    }
    
    private func getWorkSchedule() {
        let loginClient = LoginClient()
        
        // First get all employees.
        loginClient.getEmployees(NSURL(string: allEmployeesURLString)!) { (employees) in
            print(employees)
            self.employees = employees
            self.getWorks(from: employees) { (works) in
                if works.count > 0 {
                    self.allWorks += works
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.tableView.reloadData()
                    })
                }
            }
        }
    }
    
    private func getWorks(from employees: [Employee], completionHandler: ([Work] -> Void)) {
        for employee in employees {
            let employeeID = employee.id
            let urlString = workScheduleEachEmployeeBaseURLString + String(employeeID) + apiPartURLString
            
            let request = NSURLRequest(URL: NSURL(string: urlString)!)
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
                                    let works = WorkGenerator.schedule_generateWorks(employee: employee, objects: objects)
                                    if let works = works {
                                        completionHandler(works)
                                    }
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
    }
    
    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleTableViewCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        let work = worksDate[indexPath.row]
        let first = work.employeeObj?.first_name
        let last = work.employeeObj?.last_name
        cell.textLabel?.text = first! + " " + last! + ": \(work.hour) - \(work.endingHour)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worksDate.count
    }
    
    // MARK: - CalendarViewDelegate
    
    func CLCalendarBehaviorAttributes() -> [NSObject : AnyObject]! {
        return [CLCalendarWeekStartDay : 2]
    }
    
    
    func dailyCalendarViewDidSelect(date: NSDate!) {
        worksDate.removeAll()
        self.tableView.reloadData()
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        print(year)
        print(month)
        print(day)
        
        for work in allWorks {
            
            if work.year == year && work.day == day && work.month == month{
                print(" YEs I work this day ok")
                print(work.year)
                self.worksDate.append(work)
                self.tableView.reloadData()
            }
        }
    }

}
