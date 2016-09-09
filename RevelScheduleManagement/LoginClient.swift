//
//  LoginClient.swift
//  RevelScheduleManagement
//
//  Created by Keita Ito on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import Foundation

struct LoginClient {
    func login(url: NSURL, completionHandler: (Work) -> () ) {
        let request = NSURLRequest(URL: url)
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
                                
                                if let works = works {
                                    let work = works[0]
                                    completionHandler(work)
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