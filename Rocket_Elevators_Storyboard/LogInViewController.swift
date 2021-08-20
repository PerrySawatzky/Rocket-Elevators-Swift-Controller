//
//  LogInViewController.swift
//  Rocket_Elevators_Storyboard
//
//  Created by officeimac on 2021-08-20.
//

import UIKit

struct Employees: Codable {
//    let elevator: Elevator
    let id: Int
    let email: String
}

class LogInViewController: UIViewController {
    
    @IBOutlet var field1: UITextField!
    
    @IBOutlet var welcome: UILabel!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        field1.autocorrectionType = .no
    }
    
    func invalidEmailAlert() {
        let alert = UIAlertController(title: "Invalid Email Address", message: "" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
       
        present(alert, animated: true)
    }
    @IBAction func didTapLogin() {
        //print("LOggin gin")
        if field1.text == "" {
            let alert = UIAlertController(title: "Enter Email Address", message: "" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

            present(alert, animated: true)
        }
        else {
            spinner.startAnimating()
            print(field1.text ?? "texts")
            let enteredEmail = field1.text
           
            guard let url = URL(string: "https://whispering-tundra-91467.herokuapp.com/api/Employees/") else {
                       print("Error: cannot create URL")
                       return
                   }
                   // Create the url request
                   var request = URLRequest(url: url)
                   request.httpMethod = "GET"
                   URLSession.shared.dataTask(with: request) { data, response, error in
                       guard error == nil else {
                           print("Error: error calling GET")
                           print(error!)
                           return
                       }
                       guard let data = data else {
                           print("Error: Did not receive data")
                           return
                       }
                       guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                           print("Error: HTTP request failed")
                           return
                       }
                    //print(data)
                    do {
                        let jsonResult = try JSONDecoder().decode([Employees].self, from: data)
                        for user in jsonResult {
                            if user.email == enteredEmail! {
                                DispatchQueue.main.async {
                                print("yessss")
                                let vc = self.storyboard?.instantiateViewController(identifier: "home") as! ViewController
                                self.present(vc,animated: true)
                                //boolvalue = true
                                }
                            }
                        }
                    }
                    catch {
                        print(error, "this error")
                    }
                }.resume()
            spinner.stopAnimating()
            //End of else statement
        }
    }

}
