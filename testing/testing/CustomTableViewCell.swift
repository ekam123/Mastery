//
//  CustomTableViewCell.swift
//  testing
//
//  Created by Ekam Singh Dhaliwal on 2019-07-22.
//  Copyright © 2019 ekam-singh. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet private var name: UILabel!
    @IBOutlet private var dateCreated: UILabel!
    @IBOutlet private var detailedDescription: UILabel!
    private(set) var plan: Plan?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPlan(_ plan: Plan?) {
        guard let plan = plan else {
            fatalError("Not allowed to assign nil to a cell's plan")
        }
        self.plan = plan
        self.name.text = self.plan?.name
        self.dateCreated.text = "\(self.plan?.dateOfBirth)"
        self.detailedDescription.text = self.plan?.purpose
    }
}
