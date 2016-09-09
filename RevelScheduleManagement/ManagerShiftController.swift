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
        
        cell.startingShift.text = String(format:"%f", tempDroppedUsers.start)
        cell.endingShift.text = String(tempDroppedUsers.end)
        cell.reason.text = tempDroppedUsers.reason
        
        cell.backgroundColor = UIColor.redColor()
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropedUsersInfo.count
    }
}
