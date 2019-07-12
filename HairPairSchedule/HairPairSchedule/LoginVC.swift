//
//  LoginVC.swift
//  
//
//  Created by Justin Vo on 6/20/19.
//

import Foundation
import CoreData
import UIKit
import Firebase

class LoginVC: UIViewController {
    
    var firebase: DatabaseReference?
    var user: User?
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginVC: viewDidLoad()")
        
        self.navigationItem.hidesBackButton = true
        self.firebase = Database.database().reference()
    }
    
    @IBAction func login(_ sender: UIButton) {
        let usernameText = usernameField.text!
        let passwordText = passwordField.text!
        loginIfValid(usernameText: usernameText, passwordText: passwordText)
    }
    
    func loginIfValid(usernameText: String, passwordText: String) {
        // Present a loading screen alert
        let loadAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let activity = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        activity.style = .gray
        activity.startAnimating()
        loadAlert.view.addSubview(activity)
        present(loadAlert, animated: true)
        
        // Look at Firebase to verify
        self.firebase!.child("users").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                // Grab the data from the user
                let id = Int(child.key)
                let name = child.childSnapshot(forPath: "name").value as! String
                let username = child.childSnapshot(forPath: "username").value as! String
                let password = child.childSnapshot(forPath: "password").value as! String
                
                // Check if the username and password match with the text fields
                if username == usernameText && password == passwordText {
                    let validUser = User(id: id!, name: name, username: username, password: password)
                    self.user = validUser
                    
                    loadAlert.dismiss(animated: false) {
                        self.performSegue(withIdentifier: "LoadingSegue", sender: self)
                        return
                    }
                }
            }
            
            // If we get here, then invalid username / password
            loadAlert.dismiss(animated: false) {
                let alert = UIAlertController(title: "Could not verify", message: "Your username or password was entered incorrectly.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "LoadingSegue":
            let loadingVC = segue.destination as! LoadingVC
            loadingVC.user = self.user
        default:
            print("LoginVC: default case")
        }
    }
}
