//
//  EmotionIconCollectionViewCell.swift
//  Signature
//
//  Created by Thanh-Tam Le on 11/25/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import UIKit

class EmotionIconCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImgView.layer.cornerRadius = 5
    }

    @IBOutlet weak var iconImgView: UIImageView!
}
