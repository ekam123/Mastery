//
//  GoalDescriptionTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-28.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class GoalDescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    
    
    @IBOutlet weak var goalDescriptionTitle: UILabel!
    @IBOutlet weak var goalDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        goalDescription.delegate = self
        
        goalDescription.frame.size.height = 60
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let goalName = goalDescription.text,
            let rangeOfTextToReplace = Range(range, in: goalName) else {
                return false
        }
        let substringToReplace = goalName[rangeOfTextToReplace]
        let count = goalName.count - substringToReplace.count + text.count
        return count <= 200
    }
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
