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
    func logout(completion: @escaping (Result<Session, Error>) -> ())

    func getUserById(id: String, completion: @escaping (Result<UserInformation, Error>) -> ())
    func getStudentLocation(uniqueKey: String?, completion: @escaping (Result<StudentResponse, Error>) -> ())
    func postStudentLocation(student: Student, completion: @escaping (Result<Student, Error>) -> ())

}

class NetworkManager: Networkable {

    let provider = MoyaProvider<ApiClient>(plugins: [NetworkLoggerPlugin()])

    func login(udacity: Udacity, completion: @escaping (Result<UserUdacity, Error>) -> ()) {
        request(target: .login(udacity: udacity), skipData: true, completion: completion)
    }

    func logout(completion: @escaping (Result<Session, Error>) -> ()) {
        request(target: .logout, skipData: true, completion: completion)
    }

    func getUserById(id: String, completion: @escaping (Result<UserInformation, Error>) -> ()) {
        request(target: .getStudentById(id: id), skipData: true, completion: completion)
    }

    func getStudentLocation(uniqueKey: String?, completion: @escaping (Result<StudentResponse, Error>) -> ()) {
        request(target: .getStudentLocation(uniqueKey: uniqueKey), skipData: false, completion: completion)
    }

    func postStudentLocation(student: Student, completion: @escaping (Result<Student, Error>) -> ()) {
        request(target: .postStudentLocation(student: student), skipData: false, completion: completion)
    }
}

private extension NetworkManager {

    private func request<T: Decodable>(target: ApiClient, skipData: Bool, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    if skipData {
                        let range: Range = 5..<response.data.count
                        let newData = response.data.subdata(in: range)
                        let results = try JSONDecoder().decode(T.self, from: newData)
                        print(String(data: newData, encoding: .utf8)!)
                        completion(.success(results))

                    } else {
                        let results = try JSONDecoder().decode(T.self, from: response.data)
                        print(String(data: response.data, encoding: .utf8)!)
                        completion(.success(results))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
