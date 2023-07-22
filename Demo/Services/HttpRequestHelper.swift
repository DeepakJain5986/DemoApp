//
//  HttpRequestHelper.swift
//  Demo
//
//  Created by Deepak on 20/07/23.
//

import Foundation

class HttpRequestHelper {
    
    //MARK: Method for call "GET" type Remote Api
    func GET(url: String, params: [String: String], complete: @escaping (Bool, Data?) -> ()) {
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
    
    //MARK: Method for call "POST" type Remote Api
    func POST(url: String,params: [String:String], complete: @escaping (Bool, Data?) -> ()) {
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let config = URLSessionConfiguration.ephemeral
            let session = URLSession(configuration: config)
            
            session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: problem calling GET")
                    print(error!)
                    complete(false, nil)
                    return
                }
                guard let data = data else {
                    print("Error: did not receive data")
                    complete(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    complete(false, nil)
                    return
                }
                complete(true, data)
            }.resume()

        }catch{
            
        }
    }
}
