//
//  DetailViewController.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 3.04.2021.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

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
        checkIsFavorited()
        closeButtonBackground()
    }
    private func closeButtonBackground(){
        self.closeButton.backgroundColor = UIColor(red: 200.0/255.0, green:200.0/255.0, blue:200.0/255.0, alpha:0.5)
    }
    private func checkIsFavorited(){
        if let id = viewModel?.id, AppSession.shared.isFavorite(id: id){
            favoriteButton.setImage(UIImage(named: "heartfill"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        
        guard let viewModel = viewModel else {return}
        AppSession.shared.addAndRemoveFavorite(id: viewModel.id)
        checkIsFavorited()

    }
        
        
        
}
  





