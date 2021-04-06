//
//  HomeHeaderCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//

import UIKit
import Kingfisher

class HomeHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func configure(game: Game?){
        guard let url = game?.background_image else {return}
        self.thumbnailImageView.kf.setImage(with: url)
    }
}
