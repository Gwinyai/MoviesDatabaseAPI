//
//  HTTPNetworkRequest.swift
//  Movies
//
//  Created by Gwinyai Nyatsoka on 27/2/2022.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

struct HTTPNetworkRequest {
    
    static func configureHTTPRequest(from route: HTTPNetworkRoute, with parameters: HTTPParameters, includes headers: HTTPHeaders, and method: HTTPMethod) throws -> URLRequest {
        guard let url = URL(string: "\(APIClient.shared.baseURL)\(route.rawValue)") else {
            throw HTTPNetworkingError.missingURL
        }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        return request
    }
    
    static func configureParametersAndHeaders(parameters: HTTPParameters?, headers: HTTPHeaders?, request: inout URLRequest) throws {
        do {
            if let headers = headers,
            let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
        } catch {
            throw HTTPNetworkingError.encodingFailed
        }
    }
    
}
