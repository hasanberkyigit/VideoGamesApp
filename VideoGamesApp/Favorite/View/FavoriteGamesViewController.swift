//
//  FavoriteGamesViewController.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 4.04.2021.
//

import UIKit

class FavoriteGamesViewController: UIViewController {
  
    private var viewModel = FavoriteViewModel()
    private var collectionView: UICollectionView?
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width - 4, height: view.frame.size.height/6 - 4)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshScreen()
    }
    
    private func initView(){
        view.backgroundColor = .white
        initCollectionView()
    }
    
    private func initCollectionView() {
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: flowLayout)
        
        guard let collectionView = collectionView else {return}
        collectionView.backgroundColor = .clear
        collectionView.register(FavoriteGameCollectionViewCell.self,
                                forCellWithReuseIdentifier: FavoriteGameCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    private func initViewModel() {
        viewModel.load()
    }
    
    private func refreshScreen() {
        viewModel.load()
        collectionView?.reloadData()
    }
}

extension FavoriteGamesViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteGameCollectionViewCell.identifier, for: indexPath) as! FavoriteGameCollectionViewCell
        cell.configure(game: viewModel.cellForItemAt(index: indexPath.row))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailsVC") as DetailViewController
        detailVC.setViewModel(viewModel: viewModel.didSelectRowAt(index: indexPath.row))
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
    }
}
