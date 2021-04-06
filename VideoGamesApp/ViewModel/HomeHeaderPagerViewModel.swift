//
//  HomeHeaderPagerViewModel.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//

import Foundation


class HomeHeaderPagerViewModel{
    
    let games: [Game]
    
    init(games: [Game]) {
        self.games = games
    }
}

extension HomeHeaderPagerViewModel {
    func numberOfRowsInSection() -> Int{
        return games.count
    }
    
    func cellForRowAt(index: Int) -> Game {
        return games[index]
    }
    
}
