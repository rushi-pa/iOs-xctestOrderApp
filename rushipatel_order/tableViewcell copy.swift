//
//  tableViewcell.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-02-18.
//

import UIKit

class tableViewcell: UITableViewCell {

    @IBOutlet weak var t1 : UILabel!
    @IBOutlet weak var t2 : UILabel!
    @IBOutlet weak var t3 : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
