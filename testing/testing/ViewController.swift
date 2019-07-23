//
//  ViewController.swift
//  testing
//
//  Created by Ekam Singh Dhaliwal on 2019-07-19.
//  Copyright © 2019 ekam-singh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var user = [User]()
    var goals = [Goal]()
    var tasks = [Task]()
    var plans = [Plan]()
    var planToSend: Plan?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //uncomment when loading the app for the first time
//        initializeData()
//        tableView.reloadData()
        let fetchRequest = NSFetchRequest<Plan>(entityName: "Plan")
//        let sortDescriptor = NSSortDescriptor(key: "deadline", ascending: false)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let plans =  try PersistenceService.context.fetch(fetchRequest)
            self.plans = plans
            self.tableView.reloadData()
        } catch {
            print("Oh no, there is no data to load")
        }

        
    }


    @IBAction func onPlusTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add User", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Name"
        }
        let action = UIAlertAction(title: "Save", style: .default, handler: {alert in
            let firstTextField = alertController.textFields![0] as UITextField
            let user = User(context: PersistenceService.context)
            user.id = UUID()
            user.name = firstTextField.text
            PersistenceService.saveContext()
            self.user.append(user)
            })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addToCell", for: indexPath) as! CustomTableViewCell
        cell.setPlan(plans[indexPath.row])

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        planToSend = plans[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailViewController = segue.destination as? DetailedViewController {
                detailViewController.goal = planToSend
            }
        }
    }
    
    
}

extension ViewController {
    func initializeData() {
        
        let t1 = Task(context: PersistenceService.context)
        t1.id =  UUID()
        t1.name = "watch lectures"
        t1.taskDescription =  "complete first 5 videos"
        t1.isComplete =  false
        t1.dateOfBirth = Date.init(timeIntervalSinceNow: 52000) as NSDate
        t1.dateOfActivity =  nil
        t1.lengthOfActivity =  2
        t1.deadline = Date.init(timeIntervalSinceNow: 64000) as NSDate
        t1.completionDate = nil
        t1.timeEstimate = 2
        t1.location = nil
        t1.preRequisiteTasks = nil
        t1.priority = "low"
        
        let t2 = Task(context: PersistenceService.context)
        t2.id =  UUID()
        t2.name = "finish last season"
        t2.taskDescription =  "Mr Robot"
        t2.isComplete =  false
        t2.dateOfBirth = Date.init(timeIntervalSinceNow: 3600) as NSDate
        t2.dateOfActivity =  Date.init(timeIntervalSinceNow: 4600) as NSDate
        t2.lengthOfActivity =  2
        t2.deadline = Date.init(timeIntervalSinceNow: 36000) as NSDate
        t2.completionDate = nil
        t2.timeEstimate = 2
        t2.location = nil
        t2.preRequisiteTasks = nil
        t2.priority = "medium"
        
        let t3 = Task(context: PersistenceService.context)
        t3.id =  UUID()
        t3.name = "complete bootcamp"
        t3.taskDescription =  "can ya feel it?"
        t3.isComplete =  true
        t3.dateOfBirth = Date.init(timeIntervalSinceNow: 46000) as NSDate
        t3.dateOfActivity =  Date.init(timeIntervalSinceNow: 3600) as NSDate
        t3.lengthOfActivity =  2
        t3.deadline = Date.init(timeIntervalSinceNow: 3600) as NSDate
        t3.completionDate = nil
        t3.timeEstimate = 2
        t3.location = nil
        t3.preRequisiteTasks = nil
        t3.priority = "low"
        
        let t4 = Task(context: PersistenceService.context)
        t4.id =  UUID()
        t4.name = "watch plants grow"
        t4.taskDescription =  "grow some plants"
        t4.isComplete =  true
        t4.dateOfBirth = Date.init() as NSDate
        t4.dateOfActivity =  Date.init(timeIntervalSinceNow: 3600) as NSDate
        t4.lengthOfActivity =  2
        t4.deadline = Date.init(timeIntervalSinceNow: 3600) as NSDate
        t4.completionDate = nil
        t4.timeEstimate = 2
        t4.location = nil
        t4.preRequisiteTasks = nil
        t4.priority = "low"
        
        
        let amirCourse = Plan(context: PersistenceService.context)
        amirCourse.id = UUID()
        amirCourse.name = "Amir Course"
        amirCourse.dateOfBirth = Date.init() as NSDate
        amirCourse.isComplete = false
        amirCourse.preRequisitePlans = nil
        amirCourse.deadline = [Date.init(timeIntervalSinceNow: 15000)]
        amirCourse.purpose = "Learn to make an app"
        
        
        let lhl = Plan(context: PersistenceService.context)
        lhl.id = UUID()
        lhl.name = "final project"
        lhl.dateOfBirth = Date.init() as NSDate
        lhl.isComplete = false
        lhl.preRequisitePlans = nil
        lhl.deadline = [Date.init(timeIntervalSinceNow: 3600)]
        lhl.purpose = "finish the bootcamp"
        
        
        let goal1 = Goal(context: PersistenceService.context)
        goal1.id = UUID()
        goal1.name = "learn iOS"
        goal1.purpose = "I want to be a programmer"
        goal1.isComplete = false
        goal1.dateOfBirth = Date.init() as NSDate
        goal1.deadline = []
        
        PersistenceService.saveContext()
        goals.append(goal1)
        tasks = [t1,t2,t3,t4]
        plans = [amirCourse, lhl]
        tableView.reloadData()

    }
}






