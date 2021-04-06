//
//  DetailViewController.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 3.04.2021.
//

import UIKit
import RxSwift
import Kingfisher


protocol UpdateDetailImageDelegate {
    func updateImage()
}

protocol FavoriteDelegate {
    func didFavorite()
}

class DetailViewController: UIViewController {
    
    //MARK: - Variables
    private var viewModel: GameDetailViewModel?{
        didSet{
            viewModel?.fetchGameDetail()
        }
    }
   
    //MARK: - IBOUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var metaCriticLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindGameDetail()
        closeButton.backgroundColor = UIColor(red: 200.0/255.0, green:200.0/255.0, blue:200.0/255.0, alpha:0.5)
    }
   
    
    //MARK:- Functions
    
    func setViewModel(viewModel: GameDetailViewModel){
        self.viewModel = viewModel
    }
    func bindGameDetail(){
        viewModel?
            .gameDetail
            .subscribe(onNext: {[weak self] _ in
                self?.initView()
            }).disposed(by: viewModel?.disposeBag ?? DisposeBag())
    }
    private func initView(){
        gameNameLabel.text = viewModel?.getGameName()
        releaseDateLabel.text = viewModel?.getReleasedDate()
        metaCriticLabel.text = viewModel?.getMetacriticRate()
        gameDescriptionLabel.text = viewModel?.getGameDescription()
        gameImage.kf.setImage(with: viewModel?.getImageUrl())
//        refreshScrollView()
    }
    private func refreshScrollView(){
        let scrollViewHeight = gameImage.frame.height + gameNameLabel.frame.height + releaseDateLabel.frame.height + metaCriticLabel.frame.height + gameDescriptionLabel.frame.height
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollViewHeight)
    }
    
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func favoriteButtonClickes(_ sender: Any) {
        tapped()
    }
    
    func tapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(oneTapped))
        favoriteButton.addGestureRecognizer(tap)
        
    }
    @objc func oneTapped(){
        let icon = UIImage(systemName: "heart.fill")
        favoriteButton.setImage(icon, for: .normal)
        let likedGames = LikedGames(id: gameImage.description, name:gameNameLabel.text ?? "sa" , image: metaCriticLabel.text ?? "bos")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(likedGames){
            let userDeafults = UserDefaults.standard
            userDeafults.setValue(encoded, forKey: "SavedGames")
        }
    }

}
