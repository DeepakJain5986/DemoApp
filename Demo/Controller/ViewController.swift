//
//  ViewController.swift
//  Demo
//
//  Created by Deepak on 20/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnCreateAccount: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func setupUI(){
        
        self.btnLogin.layer.cornerRadius = 5.0
        self.btnCreateAccount.layer.borderWidth = 2.0
        self.btnCreateAccount.layer.cornerRadius = 5.0
        self.btnCreateAccount.layer.borderColor = UIColor(red: 158.0/255.0, green: 185.0/255.0, blue: 100.0/255.0, alpha: 1.0).cgColor
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {

        self.showIndicator(withTitle: "Indicator", and: "fetching details")
        
        if !validationForLogin(){
            
            //MARK: Check Internet Connection
            InternetManager.isUnreachable { _ in
                DispatchQueue.main.async {
                    self.hideIndicator()
                    self.showAlert(title: "Alert!", message: "Please check your internet connection and try again.")
                }
                return
            }
            
            self.emailIdTF.resignFirstResponder()
            self.pwdTF.resignFirstResponder()
            
            let params:[String:String] = ["email":self.emailIdTF.text!,"password":self.pwdTF.text!]
            
            AccountViewModel().postLoginData(urlString: "https://reqres.in/api/login", parameter: params, completion: { success, response, error in
                
                DispatchQueue.main.async {
                if success{
                    self.performSegue(withIdentifier: "navFromLoginToHomeVC", sender: self)
                }else{
                     self.showAlert(title: "Alert!", message: error!)
                   }
                    self.hideIndicator()
                }
          })
        }else{
            DispatchQueue.main.async {
                self.hideIndicator()
            }
        }
    }
    
    @IBAction func createBtnAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "navigateToRegistrationVC", sender: self)
    }
    
    func validationForLogin() -> Bool {
        
        guard let userEmailId = self.emailIdTF.text , userEmailId != "" else {
            self.showAlert(title: "Alert!", message: "Please enter email-id")
            return true
        }
        guard let userEmailId = self.emailIdTF.text , userEmailId.isValidEmail(userEmailId) else {
            self.showAlert(title: "Alert!", message: "Please enter valid email-id")
            return true
        }
        guard let password = self.pwdTF.text , password != "" else {
            self.showAlert(title: "Alert!", message: "Please enter password")
            return true
        }
     return false
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
}
