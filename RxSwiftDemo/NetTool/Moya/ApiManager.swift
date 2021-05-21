//
//  ApiManager.swift
//  RxSwiftDemo
//
//  Created by dueda on 2021/4/9.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper
import RxCocoa

enum ApiManager {
    case requestHome(Int)
}
extension ApiManager: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return ["":""]
    }
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        var params:[String : Any] = [:]
        switch self {
            case .requestHome(let page):
                params = ["page":page]
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}




