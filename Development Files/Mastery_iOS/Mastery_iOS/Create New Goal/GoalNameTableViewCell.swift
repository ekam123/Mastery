//
//  GoalNameTableViewCell.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol GoalNameCellDelegate {
    func getValueForName(theName: String)
}

class GoalNameTableViewCell: UITableViewCell, UITextFieldDelegate {

   
    
    @IBOutlet var name: UITextField!
    
     var delegate: GoalNameCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        name.delegate = self
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let name = name.text,
            let rangeOfTextToReplace = Range(range, in: name) else {
                return false
        }
        let substringToReplace = name[rangeOfTextToReplace]
        let count = name.count - substringToReplace.count + string.count
        return count <= 30
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
       
        super.setSelected(selected, animated: animated)
        
    }

    
    func textFieldDidChange(_ textField: UITextField) {
        name.resignFirstResponder()
        print("Is this sucker being called?")
        self.delegate?.getValueForName(theName: name.text!)
        
        
    }
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField)
        return true
    }
    
    
}
