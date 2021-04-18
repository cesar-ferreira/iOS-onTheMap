//
//  LoginViewModel.swift
//  onTheMap
//
//  Created by César Ferreira on 10/04/21.
//

import Foundation
import UIKit

protocol LoginViewModelProtocol: class {
    func didLogin()
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelProtocol?
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func login(username: String, password: String) {
        let authentication = Authentication(username: username, password: password)
        let udacity = Udacity(udacity: authentication)
        networkManager.login(udacity: udacity, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.didLogin()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

}
