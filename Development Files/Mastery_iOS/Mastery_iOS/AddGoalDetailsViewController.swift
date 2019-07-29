//
//  AddGoalDetailsViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddGoalDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate{
    
    
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

        
        goalName.delegate = self
        
//        guard let goalName = goalName,
//             let purpose = purpose,
//             let purposeTwo = purposeTwo,
//        let purposeThree = purposeThree else {return}
//        print(goalName, purpose, purposeTwo, purposeThree)

    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let value = goalName.text {
            if value.count > 10 {
                
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let goalName = goalName.text,
            let rangeOfTextToReplace = Range(range, in: goalName) else {
                return false
        }
        let substringToReplace = goalName[rangeOfTextToReplace]
        let count = goalName.count - substringToReplace.count + string.count
        return count <= 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalDescriptionCell", for: indexPath) as! GoalDescriptionTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalDeadlineCell", for: indexPath) as! GoalDeadlineTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalHoursCell", for: indexPath) as! GoalHoursTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalPriorityCell", for: indexPath) as! GoalPriorityTableViewCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalTagsCell", for: indexPath) as! GoalTagsTableViewCell
            return cell
    
        default:
            return tableView.dequeueReusableCell(withIdentifier: "Cell")!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
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






