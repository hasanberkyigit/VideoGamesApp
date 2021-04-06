//
//  GamesList.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 30.03.2021.
//

import Foundation


struct GamesList: Codable {
    
    let results: [Game]
    
}
struct Game: Codable{
    let id: Int
    let slug: String
    let name: String
    let background_image: URL
    let released: String
    let rating: Double
    let metacritic: Int
    
}
