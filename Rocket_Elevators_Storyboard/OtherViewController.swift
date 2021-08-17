//
//  OtherViewController.swift
//  Rocket_Elevators_Storyboard
//
//  Created by officeimac on 2021-08-16.
//

import UIKit

class OtherViewController: UIViewController {
    
    @IBOutlet var field: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapSave() {
        NotificationCenter.default.post(name: Notification.Name("text1"), object: field.text)
        dismiss(animated: true, completion: nil)
    }
}
