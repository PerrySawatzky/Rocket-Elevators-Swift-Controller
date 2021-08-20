//
//  OtherViewController.swift
//  Rocket_Elevators_Storyboard
//
//  Created by officeimac on 2021-08-16.
//

import UIKit

class OtherViewController: UIViewController {
    
    @IBOutlet var field1: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapSave() {
        NotificationCenter.default.post(name: Notification.Name("text1"), object: field1.text)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapLogin() {
        print("LOggin gin")
        if field1.text == nil {
            let alert = UIAlertController(title: "Enter Email Address", message: "" , preferredStyle: .alert)
            present(alert, animated: true)
        }
        else {
            print(field1.text)
        }
    }
}
