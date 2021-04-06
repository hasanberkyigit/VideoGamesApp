//
//  HomeTableCell.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//

import UIKit
import Kingfisher

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingandReleasedLabel: UILabel!
    
    func configure(game: Game){
        nameLabel.text = game.name
        ratingandReleasedLabel.text = game.rating.description + " - " + game.released
        gameImageView.kf.setImage(with: game.background_image)
    }
}
