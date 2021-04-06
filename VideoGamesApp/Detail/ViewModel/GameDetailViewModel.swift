//
//  DetailViewModel.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 3.04.2021.
//
import Foundation
import RxSwift
import RxCocoa

class GameDetailViewModel {
    
    var id: Int = 0
    let disposeBag = DisposeBag()
    let gameDetail = BehaviorRelay<GameDetail?>(value: nil)
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    init(id:Int) {
        self.id = id
    }
}
extension GameDetailViewModel{
    func getImageUrl() -> URL?{
        
        return gameDetail.value?.background_image
    }
    func getGameName() -> String? {
        return gameDetail.value?.name
    }
    func getMetacriticRate() -> String? {
        return gameDetail.value?.metacritic.description
    }
    func getReleasedDate() -> String? {
        return gameDetail.value?.released
    }
    func getGameDescription() -> String? {
        return gameDetail.value?.description_raw
    }
}


extension GameDetailViewModel {
    
    func fetchGameDetail(){
        isLoading.accept(true)
        Worker.shared.getGameDetails(id: id.description) { [weak self] (result) in
            guard let self = self else {return}
            self.isLoading.accept(false)
            switch result{
            case .success(let gameDetailSuccess):
                self.gameDetail.accept(gameDetailSuccess)
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
