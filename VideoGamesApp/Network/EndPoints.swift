//
//  Endpoints.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//

import Foundation

enum EndPoints: String{
    
    case games = "/games"
    case details = "/games/"
    
}

enum ErrorResponse: Error {
    case error(Int, String)

    var reason: (code: Int, description: String) {
        switch self {
        case let .error(errorCode, description):
            return (errorCode, description)
        }
    }
}
