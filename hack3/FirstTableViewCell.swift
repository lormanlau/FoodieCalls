//
//  TableViewCell.swift
//  hack3
//
//  Created by havisha tiruvuri on 9/19/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MainIngredientLabel: UILabel!
    @IBOutlet weak var EnterTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
