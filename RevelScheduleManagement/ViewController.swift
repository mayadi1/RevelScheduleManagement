//
//  ViewController.swift
//  RevelScheduleManagement
//
//  Created by Mohamed Ayadi on 9/8/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                }
            }
        }
        session.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

