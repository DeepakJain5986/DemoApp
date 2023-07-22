//
//  RegistrationVC.swift
//  Demo
//
//  Created by Deepak on 20/07/23.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }
    
    func setupUI(){
        
        self.btnCreate.layer.cornerRadius = 5.0
        self.btnLogin.layer.borderWidth = 2.0
        self.btnLogin.layer.cornerRadius = 5.0
        self.btnLogin.layer.borderColor = UIColor(red: 158.0/255.0, green: 185.0/255.0, blue: 100.0/255.0, alpha: 1.0).cgColor
    }

    @IBAction func createBtnAction(_ sender: UIButton) {
        
        self.showIndicator(withTitle: "Indicator", and: "fetching details")
        if !validationForCreateAccount(){
            
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
            self.confirmPwdTF.resignFirstResponder()
            
            let params:[String:String] = ["email":self.emailIdTF.text!,"password":self.pwdTF.text!]

            AccountViewModel().postCreateAccountData(urlString: "https://reqres.in/api/register", parameter: params, completion: { success, response, error in

                DispatchQueue.main.async {

                if success{
                    self.performSegue(withIdentifier: "navFromRegistrationToHomeVC", sender: self)
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
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validationForCreateAccount() -> Bool {
        
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
        guard let password = self.confirmPwdTF.text , password != "" else {
            self.showAlert(title: "Alert!", message: "Please enter confirm password")
            return true
        }
        if self.pwdTF.text != self.confirmPwdTF.text{
            self.showAlert(title: "Alert!", message: "Please match entered password and enterd confirm password")
            return true
        }
     return false
    }

}


extension RegistrationVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
}
