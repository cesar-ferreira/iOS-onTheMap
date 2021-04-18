//
//  TabBarViewModel.swift
//  onTheMap
//
//  Created by César Ferreira on 18/04/21.
//

import Foundation
import UIKit

protocol TabBarViewModelProtocol: class {
    func didLogout()
    func getStudents(result: StudentResponse)
}

class TabBarViewModel {

    weak var delegate: TabBarViewModelProtocol?
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func logout() {
        networkManager.logout(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.didLogout()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    func getStudents(uniqueKey: String?) {
        networkManager.getStudentLocation(uniqueKey: uniqueKey, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.getStudents(result: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
