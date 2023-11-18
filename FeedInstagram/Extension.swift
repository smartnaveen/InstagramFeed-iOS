//
//  Extension.swift
//  FeedInstagram
//
//  Created by Naveen Kumar on 18/11/23.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerNib<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}
