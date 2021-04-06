//
//  UIAlert+Extension.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 4.04.2021.
//

import UIKit

extension UIViewController {

  func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default) { action in
    }
    alertController.addAction(okButton)
    self.present(alertController, animated: true, completion: nil)
  }
}
