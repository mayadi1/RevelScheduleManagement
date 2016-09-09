//
//  ManagerViewController.swift
//  RevelScheduleManagement
//
//  Created by Keita Ito on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class ManagerViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let scheduleVC = ScheduleViewController()
        scheduleVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Contacts, tag: 0)
        
        
        self.viewControllers = [scheduleVC]
        self.selectedViewController = scheduleVC
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
    }


}
