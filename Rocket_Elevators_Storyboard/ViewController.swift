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
    let serial_number: String?
    let model: String?
    let elevator_type: String?
    let status: String?
    let information: String?
    let notes: String?
    let created_at: String?
    let updated_at: String?
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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    //var status1
    //Varble would be in the other view controller so you can add it to the new view.
    
    
//    var result: APIResponse?
    
    let urlString = "https://whispering-tundra-91467.herokuapp.com/api/elevators/notInOperation"
    
    @IBOutlet var label: UILabel!
    
    
   
    
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
                    
//                    NotificationCenter.default.addObserver(self, selector: #selector(self.didGetNotificaiton(_:)), name: Notification.Name("text1"), object: nil)
                }
            } else {
                
            }
            
        })
        //getData must be first since it populates the elevatorList array.
//        view.addSubview(tableView)
//        tableView.frame = view.bounds
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificaiton(_:)), name: Notification.Name("text1"), object: nil)
        
    }
    
    
    public var elevatorArray = [APIResponse]()
    
    public func getData(callback: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
//            print(data)
            do {
                let jsonResult = try JSONDecoder().decode([APIResponse].self, from: data)
//                let str = String(decoding: data, as: UTF8.self)

//                print(jsonResult)
                for elevator in jsonResult {
                    self.elevatorArray.append(elevator)
                    print(elevator.id)
                }
                callback(true)
//                print(jsonResult.count)
            }
            catch {
                print(error, "this error")
                callback(false)
            }
        }
        task.resume()
        //print(elevatorArray)
        
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
            //print("numberOfRowsInSection", elevatorArray.count)
            let model = elevatorArray.count
            return model
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //print("cellForRowAt", elevatorArray.count)
            let elevator = "Elevator "
            let model = String(self.elevatorArray[indexPath.row].id)
            let together = elevator + model
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = together
            return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let status = self.elevatorArray[indexPath.row].status
        let id = String(self.elevatorArray[indexPath.row].id)
        //print("this is the status", status!)
        let statusController = ElevatorListViewController()
        
        //statusController.status2 = "heyoo"
        print("status 2 poop oo", statusController.status2)
        let vc = storyboard?.instantiateViewController(identifier: "elevator_vc") as! ElevatorListViewController
        vc.status2 = status!
        vc.id2 = id
        present(vc,animated: true)
          }
    

    @objc func didGetNotificaiton(_ notification: Notification) {
        let text = notification.object as! String?
        label.text = text
    }
    
//    @IBAction func didTapButton() {
//        print("here?")
//        let vc = storyboard?.instantiateViewController(identifier: "1") as! OtherViewController
//        vc.modalPresentationStyle = .fullScreen
//        present(vc,animated: true)
//    }
    
    @IBAction func didTapButtonforElevator() {
        let vc = storyboard?.instantiateViewController(identifier: "elevator_vc") as! ElevatorListViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    @IBAction func dlskfgsdalfgh() {
        let vc = storyboard?.instantiateViewController(identifier: "1") as! OtherViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }


}
 

