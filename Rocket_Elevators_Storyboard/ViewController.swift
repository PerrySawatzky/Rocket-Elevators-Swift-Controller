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
    
//    var result: APIResponse?
    
    let urlString = "https://whispering-tundra-91467.herokuapp.com/api/elevators/notInOperation"
    
    @IBOutlet var label: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        //getData must be first since it populates the elevatorList array.
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificaiton(_:)), name: Notification.Name("text1"), object: nil)
        
    }
    
    
    public var elevatorArray = [APIResponse]()
    
    func getData(){
        
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
//                print(jsonResult.count)
            }
            catch {
                print(error, "this error")
            }
        }
        task.resume()
    }
    
    
    
    //tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let elevator = "Elevator 1"
    
        return elevator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection", elevatorArray.count)
        let model = elevatorArray.count
        return model
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt", elevatorArray.count)
        let model = self.elevatorArray[indexPath.row].status
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model
        return cell
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
    


}

