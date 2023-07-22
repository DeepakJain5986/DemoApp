//
//  AccountModel.swift
//  Demo
//
//  Created by Deepak on 20/07/23.
//

import Foundation

class Response: Codable {
    let token: String

    init(token: String) {
        self.token = token
    }
}

class ResponseError: Codable {
    let error: String

    init(error: String) {
        self.error = error
    }
}

class RegistrationResponse: Codable {
    let id: Int
    let token: String

    init(id: Int, token: String) {
        self.id = id
        self.token = token
    }
}
