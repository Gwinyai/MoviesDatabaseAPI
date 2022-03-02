//
//  HTTPNetworkResponse.swift
//  Movies
//
//  Created by Gwinyai Nyatsoka on 28/2/2022.
//

import Foundation

struct HTTPNetworkResponse {
    
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String, HTTPNetworkingError> {
        guard let res = response else {
            return Result.failure(HTTPNetworkingError.UnwrappingError)
        }
        switch res.statusCode {
        case 200...299: return Result.success(HTTPNetworkingError.success.rawValue)
        case 401: return Result.failure(HTTPNetworkingError.authenticationError)
        case 400...499: return Result.failure(HTTPNetworkingError.badRequest)
        case 500...599: return Result.failure(HTTPNetworkingError.serverSideError)
        default: return Result.failure(HTTPNetworkingError.failed)
        }
    }
    
}
