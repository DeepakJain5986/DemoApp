//
//  UserViewModel.swift
//  Demo
//
//  Created by Deepak on 21/07/23.
//

import Foundation

class UserViewModel{
    
    func getUserList(urlString:String,parameter:[String:String],completion: @escaping(_ success:Bool, _ result:User?, _ error:String?) -> ()){
        
        ApiService().getUserListData(url: urlString, params: parameter, completion: { success,response,error in
            
            completion(success,response,error)
        })
    }
    
    func postAddUserData(urlString:String,parameter:[String:String],completion: @escaping(_ success:Bool, _ result:User?, _ error:String?) -> ()){
        
        ApiService().addUser(url: urlString, parameter: parameter, completion: { success, response, error in
            
            completion(success,response,error)
      })
    }
}
