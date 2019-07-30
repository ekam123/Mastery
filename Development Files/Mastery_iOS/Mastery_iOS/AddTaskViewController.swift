//
//  AddTaskViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var goal: Goal?
    
    @IBOutlet weak var imageIconView: UIView!
    @IBOutlet weak var name: UITextField!
    
    var priority: UISegmentedControl!
    var taskDescription: UITextView!
    var timeEstimate: UISegmentedControl!
    var deadline: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let goal = goal else {return}
        print(goal)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveTask(_ sender: UIButton) {
        let task = Task(context: PersistenceService.context)
        task.name = name.text
        task.id = UUID()
        task.taskDescription = taskDescription.text
        task.isComplete = false
        task.dateOfBirth = Date() as NSDate
        task.timeEstimate = (timeEstimate.titleForSegment(at: timeEstimate.selectedSegmentIndex)! as NSString).floatValue
        task.deadline = deadline.date as NSDate
        task.priority = 1
        goal?.addToTasks(task)
        PersistenceService.saveContext()
    }
    
    @IBAction func goBackHome(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

extension AddTaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescriptionCell", for: indexPath)
        return cell
    }
    
    
}
