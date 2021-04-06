//
//  UIView+Extension.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//


import UIKit

extension UIView {
    
    public func showLoading(value:CGFloat,color:UIColor){
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        indicator.layer.cornerRadius=self.layer.cornerRadius
        indicator.color=color
        indicator.backgroundColor = .clear
        let transform = CGAffineTransform(scaleX: value, y:value)
        indicator.transform = transform
        self.addSubview(indicator)
        indicator.startAnimating()
    }
    public func hideLoading () {
        for view in self.subviews {
            if view is UIActivityIndicatorView {
                DispatchQueue.main.async {
                    view.removeFromSuperview()
                }
            }
        }
    }
}

