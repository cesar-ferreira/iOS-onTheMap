//
//  Udacity.swift
//  onTheMap
//
//  Created by César Ferreira on 10/04/21.
//

import Foundation

public class Udacity: Codable {

    var udacity: Authentication

    public init(udacity: Authentication) {
        self.udacity = udacity
    }
}
