//
//  NetworkManager+ResponseHandler.swift
//  edX
//
//  Created by Saeed Bashir on 6/17/16.
//  Copyright © 2016 edX. All rights reserved.
//

extension NetworkManager {
    /** Checks for the response status code and return appropriate error or data */
    public static func handlesResponse<Out> (result: NetworkResult<Out>) -> Result<Out> {
        if let response = result.response {
            let statusCode = OEXHTTPStatusCode(rawValue: response.statusCode)
            if statusCode == .Code426UpgradeRequired {
                return result.data.toResult(NSError.oex_outdatedVersionError())
            }
        }
        
        return result.data.toResult(result.error ?? NetworkManager.unknownError)
    }
}

