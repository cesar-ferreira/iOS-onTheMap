//
//  AddLinkViewModel.swift
//  onTheMap
//
//  Created by César Ferreira on 18/04/21.
//

import Foundation
import UIKit

protocol AddLinkViewModelProtocol: class {
    func didUser(user: UserInformation)
    func didStudentPosted()
}

class AddLinkViewModel {

    weak var delegate: AddLinkViewModelProtocol?
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func getUserById(id: String) {
        networkManager.getUserById(id: id, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.didUser(user: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    func postStudentLocation(student: Student) {
        networkManager.postStudentLocation(student: student, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.didStudentPosted()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

