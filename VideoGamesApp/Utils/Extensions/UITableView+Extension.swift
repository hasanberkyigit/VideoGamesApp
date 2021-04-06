//
//  TableView+Extension.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//

import UIKit

extension UITableView{
    
    func registerHomeTableCell(){
        register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
    }
    public func isLastRow(indexPath: IndexPath) -> Bool {
        guard let lastVisibleIndexpath = indexPathsForVisibleRows?.last else {
            return false
        }
        let lastRowIndexpath = IndexPath(row: numberOfRows(inSection: indexPath.section) - 1, section: indexPath.section)
        return lastVisibleIndexpath == lastRowIndexpath
    }
}
