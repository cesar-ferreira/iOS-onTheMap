//
//  ApiClient.swift
//  onTheMap
//
//  Created by César Ferreira on 06/04/21.
//

import Moya

enum ApiClient {
    case login(udacity: Udacity)
    case logout
    case getStudentById(id: String)
    case getStudentLocation(uniqueKey: String?)
    case postStudentLocation(student: Student)

}

extension ApiClient: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://onthemap-api.udacity.com/v1") else { fatalError() }
        return url
    }

    var path: String {
        switch self {
        case .login, .logout:
            return "/session"
        case .getStudentById(id: let id):
            return "/users/\(id)"
        case .getStudentLocation, .postStudentLocation:
            return "/StudentLocation"
        }
    }

    var method: Method {
        switch self {
        case .getStudentLocation, .getStudentById:
            return .get
        case .login, .postStudentLocation:
            return .post
        case .logout:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getStudentLocation(uniqueKey: let uniqueKey):
            return .requestParameters(parameters: ["uniqueKey" : uniqueKey!], encoding: URLEncoding.queryString)
        case .login(udacity: let udacity):
            return .requestJSONEncodable(udacity)
        case .postStudentLocation(student: let student):
            return .requestJSONEncodable(student)
        case .getStudentById:
            return .requestPlain
        case .logout:
            let params: [String:Any] = ["": ""]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
}
