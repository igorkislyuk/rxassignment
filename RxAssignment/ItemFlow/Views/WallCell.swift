//
//  WallCell.swift
//  RxAssignment
//
//  Created by Igor on 05/03/2017.
//  Copyright © 2017 Igor Kislyuk. All rights reserved.
//

import UIKit

class WallCell: UITableViewCell {
    
    @IBOutlet weak var itemTextLabel: UILabel!
    @IBOutlet weak var itemIDLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
