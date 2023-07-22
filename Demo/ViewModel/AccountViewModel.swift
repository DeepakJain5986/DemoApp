//
//  AccountViewModel.swift
//  Demo
//
//  Created by Deepak on 20/07/23.
//

import Foundation

class AccountViewModel: NSObject{
    
    func postLoginData(urlString:String,parameter:[String:String],completion: @escaping(_ success:Bool, _ result:Response?, _ error:String?) -> ()){
        
        ApiService().login(url: urlString, parameter: parameter, completion: { success, response, error in
            
              completion(success,response,error)
        })
    }
    
    func postCreateAccountData(urlString:String,parameter:[String:String],completion: @escaping(_ success:Bool, _ result:RegistrationResponse?, _ error:String?) -> ()){
        
        ApiService().createAccount(url: urlString, parameter: parameter, completion: { success, response, error in
            
            completion(success,response,error)
      })
    }
}
