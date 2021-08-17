//
//  ViewController.swift
//  Rocket_Elevators_Storyboard
//
//  Created by officeimac on 2021-08-16.
//

import UIKit

struct APIResponse: Codable {
//    let elevator: Elevator
    let id: Int
    let column_id: Int
    let serial_number: String
    let model: String
    let elevator_type: String
    let status: String
    let information: String
    let notes: String
    let created_at: String
    let updated_at: String
}

//struct Elevator: Codable {
//    let id: Int
//    let column_id: Int
//    let serial_number: String
//    let model: String
//    let elevator_type: String
//    let status: String
//    let information: String
//    let notes: String
//    let created_at: String
//    let updated_at: String
//}

class ViewController: UIViewController {
    
    let urlString = "https://whispering-tundra-91467.herokuapp.com/api/elevators/notInOperation"
    
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificaiton(_:)), name: Notification.Name("text1"), object: nil)
    }
    
    @objc func didGetNotificaiton(_ notification: Notification) {
        let text = notification.object as! String?
        label.text = text
    }
    
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "other") as! OtherViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    func getData(){
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode([APIResponse].self, from: data)
                
                for elevator in jsonResult {
                    print(elevator.id)
                }
//                print(jsonResult.count)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }

}

