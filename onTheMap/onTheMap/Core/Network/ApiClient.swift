//
//  ApiClient.swift
//  onTheMap
//
//  Created by César Ferreira on 06/04/21.
//

import Moya

enum ApiClient {
    case login(udacity: Udacity)
    case getStudentLocation(limit: Int?, skip: Int?, order: String?, uniqueKey: String?)
}

extension ApiClient: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://onthemap-api.udacity.com/v1") else { fatalError() }
        return url
    }

    var path: String {
        switch self {
        case .login:
            return "/session"
        case .getStudentLocation:
            return "/StudentLocation"
        }
    }

    var method: Method {
        switch self {
        case .getStudentLocation:
            return .get
        case .login:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getStudentLocation(limit: let limit, skip: let skip, order: let order, uniqueKey: let uniqueKey):

            var params: [String:Any] = ["": ""]
            if let limit = limit {
                params["limit"] = limit
            }

            if let skip = skip {
                params["skip"] = skip
            }

            if let order = order {
                params["order"] = order
            }

            if let uniqueKey = uniqueKey {
                params["uniqueKey"] = uniqueKey
            }
//            return .requestParameters(parameters: params, encoding: JSONEncoding.default)

            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .login(udacity: let udacity):
            return .requestJSONEncodable(udacity)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
}
