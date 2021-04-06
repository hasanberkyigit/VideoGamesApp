//
//  FavoriteGameCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 4.04.2021.
//

import UIKit
import Kingfisher

class FavoriteGameCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FavoriteGameCell"
        
    private let favoriteImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
//        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let gameNameLabel: UILabel = {
    let label = UILabel()
        label.text = "GTA SAN ANDREAS IV"
        label.textAlignment = .left
//        label.backgroundColor = .green
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(favoriteImageView)
        contentView.addSubview(gameNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gameNameLabel.frame = CGRect(x: contentView.frame.size.height - 20,
                                     y:contentView.frame.size.height - 80 ,
                                     width: 300,
                                     height: 20)
        favoriteImageView.frame = CGRect(x: 5,
                                     y:10 ,
                                     width: contentView.frame.size.height - 25,
                                     height: contentView.frame.size.height - 25)
    }
    
    
//    public func configure(likedGames: LikedGames){
//        gameNameLabel.text = likedGames.
//        favoriteImageView.kf.setImage(with: likedGames.image)
//    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        gameNameLabel.text = nil
//        favoriteImageView.kf.setImage(with: nil)
//    }
}
