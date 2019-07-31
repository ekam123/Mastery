//
//  AddTaskViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class CreateFirstTaskViewController: UIViewController, UITextFieldDelegate {
    
    var goal: Goal?
    
    @IBOutlet weak var imageIconView: UIView!
    @IBOutlet weak var taskName: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    private var priority: Int16?
    private var taskDescription: String?
    private var timeEstimate: UISegmentedControl!
    private var deadline: Date?
    private var availability: [Bool]?
    
    private var pickerisHidden: Bool = true
    var tagList: [String] = [String]()
    
    private var refreshCollectionView = 0 {
        didSet {
            let indexPath = IndexPath(item: 4, section: 0)
            tableView.reloadRows(at: [indexPath], with: .top)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let goalTags = goal?.tags else {return}
        tagList.append(contentsOf: goalTags)
        
        taskName.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let name = taskName.text,
            let rangeOfTextToReplace = Range(range, in: name) else {
                return false
        }
        let substringToReplace = name[rangeOfTextToReplace]
        let count = name.count - substringToReplace.count + string.count
        return count <= 30
    }
    
    
    func saveTask() {
        let task = Task(context: PersistenceService.context)
        task.name = taskName.text
        task.taskDescription = taskDescription ?? "Add description here"
        task.id = UUID()
        task.deadline = deadline as NSDate?
        task.isComplete = false
        task.dateOfBirth = Date() as NSDate
        task.priority = priority ?? 1
        task.tags = tagList
        task.daysAvailable = availability
        goal?.addToTasks(task)
        PersistenceService.saveContext()
    }
    
    @IBAction func goBackHome(_ sender: UIBarButtonItem) {
        saveTask()
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

extension CreateFirstTaskViewController: UITableViewDelegate, UITableViewDataSource, GoalDescriptionCellDelegate, DatePickerTableViewCellDelegate, GoalPriorityTableCellDelegate, TaskAvailabilityCellDelegate {
   
    
    func selectedDates(daysOfWeek: [Bool]) {
        availability = daysOfWeek
    }
    
    
    func dateChanged(toDate date: Date) {
        deadline = date
    }
    
    func getPriority(priority: Int16) {
        self.priority = priority
    }
    
    
    
    func getValueForDescription(theDescription: String) {
        taskDescription = theDescription
    }
    
    
    func showStatusPickerCell(datePicker: UIDatePicker) {
        UIView.animate(withDuration: 0.3, animations: {
            () -> Void in
            datePicker.isHidden = !datePicker.isHidden
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescriptionCell", for: indexPath) as! TaskDescriptionTableViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDeadlineCell", for: indexPath) as! TaskDeadlineTableViewCell
            cell.delegate = self
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskPriorityCell", for: indexPath) as! TaskPriorityTableViewCell
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskAvailabilityCell", for: indexPath) as! TaskAvailabilityTableViewCell
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskTagsCell", for: indexPath) as! TaskTagsTableViewCell
            cell.collectionView.reloadData()
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "Cell")!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            let height: CGFloat = pickerisHidden ? 40.0 : 210
            return height
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateIndexPath = IndexPath(row: 1, section: 0)
        if dateIndexPath == indexPath {
            pickerisHidden = !pickerisHidden
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CreateFirstTaskViewController : UICollectionViewDelegate, UICollectionViewDataSource, EmptyTagCollectionViewCellDelegate {
    
    
    func addTagToList(tagName: String) {
        tagList.append(tagName)
        if refreshCollectionView >= 2 {
            refreshCollectionView = 0
        } else {
            refreshCollectionView += 1
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < tagList.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goalsCreatedTagCell", for: indexPath) as! TagCreatedTaskCollectionViewCell
            cell.tagName.text = tagList[indexPath.row]
            return cell
        } else {
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goalsEmptyTagCell", for: indexPath) as! TagEmptyTaskCollectionViewCell
        cell.delegate = self
        return cell
    }
}



