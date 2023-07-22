//
//  AddUserVC.swift
//  Demo
//
//  Created by Deepak on 21/07/23.
//

import UIKit

class AddUserVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var jobTitleTF: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUPUI()
    }
    
    func setUPUI(){
        
        self.btnCancel.layer.cornerRadius = 5.0
        self.btnSubmit.layer.cornerRadius = 5.0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        self.showIndicator(withTitle: "Indicator", and: "processing...")
        
        if !validationForAddUser(){
            
            //MARK: Check Internet Connection
            InternetManager.isUnreachable { _ in
                DispatchQueue.main.async {
                    self.hideIndicator()
                    self.showAlert(title: "Alert!", message: "Please check your internet connection and try again.")
                }
                return
            }
            self.nameTF.resignFirstResponder()
            self.jobTitleTF.resignFirstResponder()
            
            let params:[String:String] = ["name":self.nameTF.text!,"job":self.jobTitleTF.text!]
            
            UserViewModel().postAddUserData(urlString: "https://reqres.in/api/users", parameter: params, completion: { success, response, error in
                
                DispatchQueue.main.async {
                if success{
                    self.dismiss(animated: true, completion: nil)
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
    
    func validationForAddUser() -> Bool {
        
        guard let nameStr = self.nameTF.text , nameStr != "" else {
            self.showAlert(title: "Alert!", message: "Please enter name")
            return true
        }
        guard let jobTitleStr = self.jobTitleTF.text , jobTitleStr != "" else {
            self.showAlert(title: "Alert!", message: "Please enter job title")
            return true
        }
        
     return false
    }
}


extension AddUserVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
}
