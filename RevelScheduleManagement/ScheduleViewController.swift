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
        
        
        
        loginClient.getAllWorks(NSURL(string: allWorksURLString)!) { (works) in
            dispatch_async(dispatch_get_main_queue(), { 
                self.allWorks = works
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleTableViewCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        let work = allWorks[indexPath.row]
        cell.textLabel?.text = work.employee
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allWorks.count
    }
    
    // MARK: - CalendarViewDelegate
    
    func CLCalendarBehaviorAttributes() -> [NSObject : AnyObject]! {
        return [CLCalendarWeekStartDay : 2]
    }
    
    
    func dailyCalendarViewDidSelect(date: NSDate!) {
      //  self.tableView.reloadData()
        
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
//                self.worksDate.append(work)
                self.tableView.reloadData()
            }
        }
    }

}
