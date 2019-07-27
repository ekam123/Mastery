//
//  AddGoalDetailsViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddGoalDetailsViewController: UIViewController {
    
    var goalName: String?
    var purpose:  String?
    var purposeTwo: String?
    var purposeThree: String?
    var colorArray: [UIColor] = [UIColor(red:0.49, green:0.47, blue:0.73, alpha:1.0),
                                 UIColor(red:0.91, green:0.44, blue:0.32, alpha:1.0),
                                 UIColor(red:0.35, green:0.76, blue:0.76, alpha:1.0),
                                 UIColor(red:0.55, green:0.70, blue:0.41, alpha:1.0),
                                 UIColor(red:0.96, green:0.74, blue:0.38, alpha:1.0)]
    
    
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    @IBOutlet weak var deadline: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let goalName = goalName,
//             let purpose = purpose,
//             let purposeTwo = purposeTwo,
//        let purposeThree = purposeThree else {return}
//        print(goalName, purpose, purposeTwo, purposeThree)

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTask" {
            if let detailViewController = segue.destination as? AddTaskViewController {
                detailViewController.goal = saveGoalData()
            }
        }
        
    }
 
    func saveGoalData() -> Goal {
        let goal = Goal(context: PersistenceService.context)
        goal.id = UUID()
        goal.name = goalName
        goal.goalDescription = purpose
        goal.isComplete = false
        goal.dateOfBirth = dateOfBirth.date as NSDate
        goal.deadline?.append((deadline.date) as Date)
        goal.hoursEstimate = 10.0
        goal.hoursCompleted = 0.0
        goal.priority = 1
        goal.color = colorArray[Int(arc4random_uniform(UInt32(colorArray.count)))]
        
        PersistenceService.saveContext()
       return goal
    }

}
