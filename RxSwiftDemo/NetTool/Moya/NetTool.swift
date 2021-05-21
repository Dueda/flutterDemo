//
//  NetTool.swift
//  RxSwiftDemo
//
//  Created by dueda on 2021/4/10.
//

import Foundation
import Moya

let KYProvider = MoyaProvider<ApiManager>(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: [KYNetworkPlugin()])

let requestClosure = { (endpoint: Moya.Endpoint, done: MoyaProvider<ApiManager>.RequestResultClosure) in
    // Using the `as!` forced type cast operator is safe here,
    // as `mutableCopy()` will always return the correct type.
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 60
        done(.success(request))
    }catch {
        
    }
}

let endpointClosure = { (target: ApiManager) -> Moya.Endpoint in
    
    let url: String
    if target.path.contains("http"){
           url = target.path
    }else if target.path.contains("?") {
        url = target.baseURL.absoluteString + target.path
    }else {
        url = target.baseURL.appendingPathComponent(target.path).absoluteString
    }
    
    let endpoint = Moya.Endpoint(
        url : url,
        sampleResponseClosure: {
            Moya.EndpointSampleResponse.networkResponse(200, target.sampleData)
    },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    
    return endpoint
}

struct KYNetworkPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
    }
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result
    }
    
}
