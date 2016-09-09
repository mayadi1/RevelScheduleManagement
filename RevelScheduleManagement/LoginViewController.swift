//
//  LoginViewController.swift
//  RevelScheduleManagement
//
//  Created by Keita Ito on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(sender: UIButton) {
        print("loginButtonClicked")
        print("\(inputTextField.text)")
        guard let inputString = inputTextField.text else { return }
        let urlString = createURLString(inputString: inputString)
        if let urlString = urlString {
            let url = NSURL(string: urlString)!
            login(url)
        }
    }

    private func createURLString(inputString inputString: String) -> String? {
        guard inputString.characters.count > 0 else { return nil }
        return baseURLString + timePartURLString + inputString + apiPartURLString
    }
    
    private func login(url: NSURL) {
        let loginClient = LoginClient()
        loginClient.login(url) { (work) in
            let role = work.role
            
            if role == "/resources/Role/2/" { // Manager
                // Go to manager screen.
            } else {
                // Go to employee screen.
                
                dispatch_async(dispatch_get_main_queue(), { 
                    let loginStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let employeeViewController: UIViewController = loginStoryBoard.instantiateViewControllerWithIdentifier("EmployeeViewController")
                    self.presentViewController(employeeViewController, animated: true, completion: nil)
                })

                // Instantiate VC.
                // Pass id number.
            }
        }
    }
}
