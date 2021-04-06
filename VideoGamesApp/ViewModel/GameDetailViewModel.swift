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
    
    
    var id: String = ""
    let gameDetails = BehaviorRelay<GameDetail?>(value: nil)
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    init(id:String) {
        self.id = id
    }
}
extension GameDetailViewModel{
    func getId(){
        
    }
}


extension GameDetailViewModel {
    
    func fetchGameDetails(){
        isLoading.accept(true)
        Worker.shared.getGameDetails(id: id) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .success(let gameDetailSuccess):
                print(result)
                
                
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
