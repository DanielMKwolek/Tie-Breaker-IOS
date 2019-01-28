//
//  CoinFlipTableViewCell.swift
//  Tie Breaker
//
//  Created by Daniel Kwolek on 1/27/19.
//  Copyright © 2019 Daniel Kwolek. All rights reserved.
//

import UIKit

class CoinFlipTableViewCell: UITableViewCell {
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
