//
//  RequestTableCell.swift
//  ceb_tea
//
//  Created by tayfun biyikoglu on 08/02/15.
//  Copyright (c) 2015 tayfun biyikoglu. All rights reserved.
//

import UIKit

class RequestTableCell: UITableViewCell {

   
    @IBOutlet weak var username: UILabel!
    
    var object_id = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
