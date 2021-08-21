//
//  ElevatorListViewController.swift
//  Rocket_Elevators_Storyboard
//
//  Created by officeimac on 2021-08-19.
//

import UIKit

class ElevatorListViewController: UIViewController {
 
    public var id2 = "test"
    public var column_id2 = "test"
    public var serial_number2 = "test"
    public var model2 = "test"
    public var status2 = "test"
    public var elevator_type2 = "test"
    public var information2 = "test"
    
    @IBOutlet var id: UILabel!
    @IBOutlet var column_id: UILabel!
    @IBOutlet var serial_number: UILabel!
    @IBOutlet var model: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var elevator_type: UILabel!
    @IBOutlet var information: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id.text = id2
        column_id.text = column_id2
        serial_number.text = serial_number2
        model.text = model2
        status.text = status2
        elevator_type.text = elevator_type2
        information.text = information2
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapSavehere() {
        dismiss(animated: true, completion: nil)
    }
    //Sets elevator status online
    @IBAction func apiCall() {
        
        let elevatorID = self.id.text
        print(elevatorID!)
        let url1 = "https://whispering-tundra-91467.herokuapp.com/api/elevators/\(elevatorID!)"
        
        let alert = UIAlertController(title: "Set Elevator \(elevatorID!) to Online", message: "Are you sure?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                //print("success")
                guard let url = URL(string: url1) else {
                    return
                }
                var request = URLRequest(url: url)
                
                request.httpMethod = "PUT"
                //Put request is handled by my API so I put _ in place of data
                URLSession.shared.dataTask(with: request) { _, response, error in
                        guard error == nil else {
                            print("Error: error calling PUT")
                            print(error!)
                            return
                        }
                        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                            print("Error: HTTP request failed")
                            return
                        }
                    }.resume()
                
                //This delays the view long enough for the elevator list to update
                sleep(1)
                //This brings the users back to the home page and updates the list of elevators
                let vc = self.storyboard?.instantiateViewController(identifier: "home") as! ViewController
                self.present(vc,animated: false)
                
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
   }
   

}
