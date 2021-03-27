//
//  MainCell.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-02-16.
//

import UIKit

class MainCell: UICollectionViewCell {
    @IBOutlet weak var image :UIImageView!
    
    @IBOutlet weak var bgcol :UIView!
    @IBOutlet weak var tit : UILabel!
    override func awakeFromNib() {
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
    }
}
