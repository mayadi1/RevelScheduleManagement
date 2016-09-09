//
//  DroppingUsersTableViewCell.swift
//  RevelScheduleManagement
//
//  Created by Mohamed Ayadi on 9/9/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class DroppingUsersTableViewCell: UITableViewCell {

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var startingShift: UILabel!
    @IBOutlet weak var endingShift: UILabel!
    @IBOutlet weak var reason: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
