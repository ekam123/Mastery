//
//  AddGoalDetailsViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddGoalDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var colorArray: [UIColor] = [UIColor(red:0.49, green:0.47, blue:0.73, alpha:1.0),
                                 UIColor(red:0.91, green:0.44, blue:0.32, alpha:1.0),
                                 UIColor(red:0.35, green:0.76, blue:0.76, alpha:1.0),
                                 UIColor(red:0.55, green:0.70, blue:0.41, alpha:1.0),
                                 UIColor(red:0.96, green:0.74, blue:0.38, alpha:1.0)]
    
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    @IBOutlet weak var deadline: UIDatePicker!
    @IBOutlet var goalName: UITextField!
    @IBOutlet var purpose: UITextView!
    @IBOutlet var purposeTwo: UITextView!
    @IBOutlet var purposeThree: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let goalName = goalName,
//             let purpose = purpose,
//             let purposeTwo = purposeTwo,
//        let purposeThree = purposeThree else {return}
//        print(goalName, purpose, purposeTwo, purposeThree)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case <#pattern#>:
            <#code#>
        default:
            <#code#>
        }
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
        goal.name = goalName.text
        goal.goalDescription = purpose.text
        goal.isComplete = false
        goal.dateOfBirth = dateOfBirth.date as NSDate
        goal.deadline?.append((deadline.date) as Date)
        goal.hoursEstimate = 10.0
        goal.hoursCompleted = 0.0
        goal.priority = 1
        //        goal.color = colorArray[Int(arc4random_uniform(UInt32(colorArray.count)))]
        goal.color = getColorFromUserDefaults(colorArray: colorArray)
        
        PersistenceService.saveContext()
       return goal
    }

    
    
    func getColorFromUserDefaults(colorArray: [UIColor]) -> UIColor {
        if let colorIndex  = UserDefaults.standard.object(forKey: "goalColorIndex") as? Int {
            if colorIndex == colorArray.count - 1 {
                UserDefaults.standard.set(0, forKey: "goalColorIndex")
                return colorArray[0]
            } else {
                UserDefaults.standard.set(colorIndex + 1, forKey: "goalColorIndex")
                return colorArray[colorIndex + 1]
            }
        }
        else {
            UserDefaults.standard.set(0, forKey: "goalColorIndex")
            return colorArray[0]
        }
    }
    
}






