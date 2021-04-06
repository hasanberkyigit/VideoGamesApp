//
//  AppSession.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 5.04.2021.
//

import Foundation


class AppSession {
    
    static let shared = AppSession()
    var favoriteGamesID: [Int] = []
    var games: [Game] = []
    func addAndRemoveFavorite(id: Int) {
        if isFavorite(id: id){
            for i in 0..<AppSession.shared.favoriteGamesID.count where AppSession.shared.favoriteGamesID[i] == id{
                AppSession.shared.favoriteGamesID.remove(at: i)
                break
            }
        }else{
            AppSession.shared.favoriteGamesID.append(id)
    }
        UserDefaults.standard.setValue(AppSession.shared.favoriteGamesID, forKey: Constants.favoriteGamesKey)
        UserDefaults.standard.synchronize()
    }
    func fetchFavoriteGames(){
        let favoriteGames = UserDefaults.standard.array(forKey: Constants.favoriteGamesKey) as? [Int] ?? []
        AppSession.shared.favoriteGamesID = favoriteGames
    }
    func isFavorite(id: Int) -> Bool {
        return AppSession.shared.favoriteGamesID.contains(id)
    }
    
}

