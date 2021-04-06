//
//  GamesViewModel.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 30.03.2021.
//

import Foundation
import RxSwift
import RxCocoa

class GamesViewModel {
  
    let disposeBag = DisposeBag()
    let games = BehaviorRelay<[Game]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    private var page = 1
    var headerViewModel: HomeHeaderPagerViewModel?
    
}

extension GamesViewModel {
     func nextPage(){
        self.page += 1
        fetchRequest()
    }
    
    func triggerSearch(key: String) {
        let filterGames = AppSession.shared.games.filter {$0.name.prefix(key.count) == key}
        headerViewModel = nil
        games.accept(filterGames)
    }
    
    func load() {
        let headerGames = AppSession.shared.games.enumerated().compactMap{
            $0.offset < 3 ? $0.element : nil
        }
        let updatedGames = AppSession.shared.games.enumerated().compactMap{
            $0.offset > 2 ? $0.element : nil
        }
        self.headerViewModel = HomeHeaderPagerViewModel(games: headerGames)
        self.games.accept(updatedGames)
    }
}

extension GamesViewModel {
    func numberOfRowsInSection() -> Int{
        return games.value.count
    }
    
    func cellForRowAt(index: Int) -> Game {
        return games.value[index]
    }

    func didSelectRowAt(index: Int) -> GameDetailViewModel {
        let id = cellForRowAt(index: index).id
        return GameDetailViewModel.init(id: id)
    }
}

extension GamesViewModel {
    func fetchRequest(){
        isLoading.accept(true)
        Worker.shared.getGameLists(page: page) {[weak self] (result) in
            guard let self = self else {return}
            self.isLoading.accept(false)
            switch result {
            case .success(let gameList):
                AppSession.shared.games = AppSession.shared.games + gameList.results
                self.load()
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
