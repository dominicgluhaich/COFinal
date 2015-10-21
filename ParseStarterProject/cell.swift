//
//  cell.swift
//  CloseOutFinal
//
//  Created by Dominic Gluhaich on 10/20/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class cell: UITableViewCell {
    @IBOutlet var itemDescription: UILabel!

    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var postedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
