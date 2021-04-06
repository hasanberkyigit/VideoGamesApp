//
//  GameDetails.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 3.04.2021.
//

import Foundation

struct GameDetail: Codable {
    let id: Int
    let name: String
    let metacritic: Int
    let description_raw: String
    let background_image: URL
    let released: String
}
