//
//  ViewController.swift
//  Rocket_Elevators_Storyboard
//
//  Created by officeimac on 2021-08-16.
//

import UIKit

struct APIResponse: Codable {
    let id: Int
    let column_id: Int
    let serial_number: String?
    let model: String?
    let elevator_type: String?
    let status: String?
    let information: String?
    let notes: String?
    let created_at: String?
    let updated_at: String?
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
//    @IBOutlet var label: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(callback: { elevatorsIn in
            //getData must be first since it populates the elevatorList array.
            
            if elevatorsIn {
                DispatchQueue.main.async {
                    // UIView usage
                    //label.text = status
                    self.view.addSubview(self.tableView)
                    self.tableView.frame = self.view.bounds
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView = UITableView(frame: .zero, style: .grouped)
                    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                }
            } else {
                //spinner maybe?
            }
        })
    }
    
    public var elevatorArray = [APIResponse]()
    
    let urlString = "https://whispering-tundra-91467.herokuapp.com/api/elevators/notInOperation"
    
    public func getData(callback: @escaping (Bool) -> ()) {
        
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
                    self.elevatorArray.append(elevator)
                    //print(elevator.id)
                }
                callback(true)
            }
            catch {
                print(error, "this error")
                callback(false)
            }
        }
        task.resume()
    }
  
    //tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let elevator = "Not In Operation"
        return elevator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = elevatorArray.count
        return model
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elevator = "Elevator "
        let model = String(self.elevatorArray[indexPath.row].id)
        let together = elevator + model
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = together
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = String(self.elevatorArray[indexPath.row].id)
        let column_id = String(self.elevatorArray[indexPath.row].column_id)
        let serial_number = self.elevatorArray[indexPath.row].serial_number
        let model = self.elevatorArray[indexPath.row].model
        let elevator_type = self.elevatorArray[indexPath.row].elevator_type
        let status = self.elevatorArray[indexPath.row].status
        let information = self.elevatorArray[indexPath.row].information
       
        let vc = storyboard?.instantiateViewController(identifier: "elevator_vc") as! ElevatorListViewController
        vc.id2 = id
        vc.column_id2 = column_id
        vc.serial_number2 = serial_number!
        vc.model2 = model!
        vc.elevator_type2 = elevator_type!
        vc.status2 = status!
        vc.information2 = information!
        
        
        present(vc,animated: true)
          }


}
 

