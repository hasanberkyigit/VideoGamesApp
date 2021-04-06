//
//  Request.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 30.03.2021.
//

import Foundation
import Alamofire

class Worker {
    
    static let shared: Worker = {
        let instance = Worker()
        return instance
    }()
    private var baseURL: String  {
        return "https://rawg-video-games-database.p.rapidapi.com"
    }
    
    private var  headers: HTTPHeaders {
        return [
        "x-rapidapi-key": "5c4762a957mshb0331fa152f060bp1cecdbjsn1b4b00c1684d",
        "x-rapidapi-host": "rawg-video-games-database.p.rapidapi.com"
    ]
    }
    
    func getGameLists(completionHandler: @escaping (Result<GamesList,NetworkError>) -> ()) {
       
        WebService().request(baseURL+"/games", headers: headers, type: GamesList.self) { (result) in
            
            switch result {
            case .success(let games):
                completionHandler(.success(games))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
}
