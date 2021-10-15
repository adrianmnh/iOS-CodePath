//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Oberon on 10/7/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        signIn()
    }
    
    func signIn(){
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error )in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Invalid username or password. \(error?.localizedDescription)")
            }
        }
        
        
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text

        user.signUpInBackground { (success, error) in
            if success {
                
                self.signIn()
                //self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
