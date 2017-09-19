//
//  SecondTableViewCell.swift
//  hack3
//
//  Created by havisha tiruvuri on 9/19/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit
import CoreData

class SecondTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dishLabel: UILabel!
    
    @IBOutlet weak var dishimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
