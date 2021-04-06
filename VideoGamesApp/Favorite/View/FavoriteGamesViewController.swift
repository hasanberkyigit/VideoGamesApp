//
//  FavoriteGamesViewController.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 4.04.2021.
//

import UIKit

class FavoriteGamesViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
  
    private var viewModel: FavoriteViewModel?{
        didSet{
//            viewModel?.fetchGameDetail()
        }
    }
    private var collectionView: UICollectionView?
    let userDeafults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDefaults()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width - 4, height: view.frame.size.height/6 - 4)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(FavoriteGameCollectionViewCell.self,
                                forCellWithReuseIdentifier: FavoriteGameCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        gameDefaults()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gameDefaults()
    }
    func setViewModel(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
    }
    func bindFavoriteGame(){
        viewModel?
            .likedGameDetails
            .subscribe(onNext: {[weak self] _ in
                self?.initView()
            }).disposed(by: viewModel!.disposeBag)
    }
    private func initView(){
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteGameCollectionViewCell.identifier, for: indexPath) as! FavoriteGameCollectionViewCell
//        cell.configure(likedGame: gameDefaults())
        return cell
    }

    

}










extension FavoriteGamesViewController{
    func gameDefaults(){
        
        if let savedGames = userDeafults.object(forKey: "SavedGames") as? Data{
            let decoder = JSONDecoder()
            if let loadedGames = try? decoder.decode(LikedGames.self, from: savedGames){
                print("-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
//                print(loadedGames.id)
                print(loadedGames.results[0].id)
                
            }
        }
    }
}
