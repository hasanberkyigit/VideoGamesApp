//
//  FavoriteViewModel.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 4.04.2021.
//

import Foundation

class FavoriteViewModel{
    var games: [Game] = []
    
    func load() {
        AppSession.shared.fetchFavoriteGames()

        games.removeAll()
        AppSession.shared.games.forEach { (game) in
            AppSession.shared.favoriteGamesID.forEach { (id) in
                if id == game.id {
                    games.append(game)
                }
            }
        }
    }
}
extension FavoriteViewModel{
    
    func numberOfItemsInSection() -> Int {
        return games.count
    }
    
    func cellForItemAt(index: Int) -> Game {
        return games[index]
    }
    func didSelectRowAt(index: Int) -> GameDetailViewModel {
        let id = cellForItemAt(index: index).id
        return GameDetailViewModel.init(id: id)
    }
    
}
extension FavoriteViewModel{
    func fetchGameUserDefaults(){
        
    }
}




