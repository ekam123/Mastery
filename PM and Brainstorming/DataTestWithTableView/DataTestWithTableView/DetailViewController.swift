//
//  DetailViewController.swift
//  MasteryTableViewTest
//
//  Created by Cameron Mcleod on 2019-07-22.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import UIKit
import os.log

class DetailViewController: UIViewController {
    
    var completionHandler:((Goal) -> Void)?
    var user : User?
    var goal : Goal?
    var name : String?
    @IBOutlet weak var nameTextFields: UITextField!
    @IBOutlet weak var goalPurposeField: UITextField!
    @IBOutlet weak var dateBornLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextFields.text = goal?.name
        goalPurposeField.text = goal?.purpose
        dateBornLabel.text = stringFromDate(date: goal!.dateOfBirth)
        
        let plans = (user?.allPlansOfGoal(goalID: goal!.id))!
        for (planID, plan) in plans {
            let planDetail = UILabel.init()
            planDetail.text = plan.name
            planDetail.font = UIFont.boldSystemFont(ofSize: 20)
            stackView.addArrangedSubview(planDetail)
            let tasks = (user?.allTasksOfPlan(planID: planID))!
            for (taskID, task) in tasks {
                let taskDetail = UILabel.init()
                taskDetail.text = task.name
                stackView.addArrangedSubview(taskDetail)
            }
        }
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        os_log("changing nameTextFields", log: OSLog.default, type: .debug)
        goal!.name = nameTextFields.text!
        goal!.purpose = goalPurposeField.text!
        completionHandler?(goal!)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func stringFromDate(date: Date ) -> String {
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
}
