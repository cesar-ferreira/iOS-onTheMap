//
//  Authentication.swift
//  onTheMap
//
//  Created by César Ferreira on 10/04/21.
//

import Foundation

public class Authentication: Codable {

    var username: String
    var password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
