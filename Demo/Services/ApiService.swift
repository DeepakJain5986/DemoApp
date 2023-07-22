//
//  ApiService.swift
//  Demo
//
//  Created by Deepak on 20/07/23.
//

import Foundation

class ApiService{
    
    func createAccount(url:String,parameter:[String:String],completion: @escaping(_ success:Bool, _ result:RegistrationResponse?, _ error:String?) -> ()){
        
        HttpRequestHelper().POST(url: url, params: parameter){ success, data in
            if success {
                do {
                    
                    let response = try? JSONDecoder().decode(RegistrationResponse.self, from: data!)
                    completion(true, response, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse json to model")
                }
            } else {
                completion(false, nil, "Error: create account post Request failed")
            }
        }
    }

    func login(url:String,parameter:[String:String],completion: @escaping(_ success:Bool, _ result:Response?, _ error:String?) -> ()){
        
        HttpRequestHelper().POST(url: url, params: parameter){ success, data in
            if success {
                do {
                    
                    let response = try? JSONDecoder().decode(Response.self, from: data!)
                    completion(true, response, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse json to model")
                }
            } else {
                completion(false, nil, "Error: create account post Request failed")
            }
        }
    }

    func getUserListData(url:String,params: [String: String],completion: @escaping (Bool, User?, String?) -> ()) {
        
        HttpRequestHelper().GET(url: url, params: params) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(User.self, from: data!)
                    completion(true, model, nil)
                }catch {
                    completion(false, nil, "Error: Trying to parse json to model")
                }
            }else {
                completion(false, nil, "Error: GET Request failed")
            }
        }
    }
    
    func addUser(url:String,parameter:[String:String],completion: @escaping(_ success:Bool, _ result:User?, _ error:String?) -> ()){
        
        HttpRequestHelper().POST(url: url, params: parameter){ success, data in
            if success {
                do {
                    
                    let response = try? JSONDecoder().decode(User.self, from: data!)
                    completion(true, response, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse json to model")
                }
            } else {
                completion(false, nil, "Error: create account post Request failed")
            }
        }
    }
}





/*
User Registration |POST | https://reqres.in/api/register
User  login  | POST | https://reqres.in/api/login
Display User list | GET | https://reqres.in/api/users?page=1
Add User  | POST | https://reqres.in/api/users
*/
