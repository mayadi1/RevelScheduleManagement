//
//  ManagerShiftController.swift
//  RevelScheduleManagement
//
//  Created by Mohamed Ayadi on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ManagerShiftController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let rootRef = FIRDatabase.database().reference()

    var dropedUsersInfo = [DroppedUsers]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "Group_0004_fourth")!)
        
        let conditionall = rootRef.child("drop")
        conditionall.observeEventType(.ChildAdded, withBlock:  { (tempSnapshot) in
            
            
            let snapshot = tempSnapshot.value
            let tempUser = DroppedUsers(tempStart: snapshot![2] as! String, tempEnd: snapshot![3] as! String, tempReason: snapshot![4] as! String, tempID: snapshot![0] as! String)
            
            
            
            
            self.dropedUsersInfo.append(tempUser)
            self.tableView.reloadData()
        })

    }

    
    //TableView Setup
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DroppingUsersTableViewCell
        
        let tempDroppedUsers = dropedUsersInfo[indexPath.row]
        
        cell.id.text = tempDroppedUsers.id
        
        cell.startingShift.text = String(tempDroppedUsers.start)
        cell.endingShift.text = String(tempDroppedUsers.end)
        cell.reason.text = tempDroppedUsers.reason
        
        cell.backgroundColor = UIColor.redColor()
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropedUsersInfo.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (UIAlertAction) in
            tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        }
        
        let dropAction = UIAlertAction(title: "Approve", style: .Default) { (UIAlertAction) in
            
            
//            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
//            
//            let request = NSURLRequest(URL: NSURL(string: "https://teama-hackathon.revelup.com/resources/TimeSchedule/202/?format=json&api_key=f98be762c10e470aa93da28701457fe8&api_secret=4f35452a0a0b4da695fa605d5e94a6c86ff94c4331524318bf0ab064b190043d")!)
//            
//            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
//                if let data = data {
//                    let response = NSString(data: data, encoding: NSUTF8StringEncoding)
//                    
//
//                    print(response!)
//                    
//                }
//                
//            }
            self.rootRef.child("delete").setValue(self.dropedUsersInfo[indexPath.row].start)
            
            self.dropedUsersInfo.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
            

        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(dropAction)
        self.presentViewController(alertController, animated: true, completion: nil)

     
        
    }
}

