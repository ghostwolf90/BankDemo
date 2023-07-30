//
//  FavoriteCollectionViewCell.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(imageString: String, title: String) {
        imageView.image = UIImage(named: imageString) ?? UIImage(named: "CUBC")
        titleLabel.text = title
    }

}
