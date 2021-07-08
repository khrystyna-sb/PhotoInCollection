//
//  CollectionViewCell.swift
//  PhotoInCollection
//
//  Created by Roma Test on 04.06.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView?
    static let identifier = "CollectionViewCell"
    

    var buttonOnImageClicked: (() -> Void)?
    
    @IBAction func action(_ sender: Any) {
            buttonOnImageClicked?()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
}
