//
//  NetworkManager.swift
//  onTheMap
//
//  Created by César Ferreira on 06/04/21.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<ApiClient> { get }

    func login(udacity: Udacity, completion: @escaping (Result<UserUdacity, Error>) -> ())

    func getStudentLocation(limit: Int?, skip: Int?, order: String?, uniqueKey: String?, completion: @escaping (Result<[Authentication], Error>) -> ())
}

class NetworkManager: Networkable {


    let provider = MoyaProvider<ApiClient>(plugins: [NetworkLoggerPlugin()])

    func login(udacity: Udacity, completion: @escaping (Result<UserUdacity, Error>) -> ()) {
        request(target: .login(udacity: udacity), completion: completion)
    }

    func getStudentLocation(limit: Int?, skip: Int?, order: String?, uniqueKey: String?, completion: @escaping (Result<[Authentication], Error>) -> ()) {
        request(target: .getStudentLocation(limit: limit, skip: skip, order: order, uniqueKey: uniqueKey), completion: completion)
    }
}

private extension NetworkManager {

    private func request<T: Decodable>(target: ApiClient, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let range: Range = 5..<response.data.count
                    let newData = response.data.subdata(in: range)
                    let results = try JSONDecoder().decode(T.self, from: newData)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
