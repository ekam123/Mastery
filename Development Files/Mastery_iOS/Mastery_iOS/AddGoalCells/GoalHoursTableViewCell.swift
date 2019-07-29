//
//  GoalHoursTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-28.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class GoalHoursTableViewCell: UITableViewCell {

    @IBOutlet weak var totalHoursTitle: UILabel!
    @IBOutlet weak var hours: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func getDate(_ sender: UISlider) {
    }
    
}
