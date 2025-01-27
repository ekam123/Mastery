//
//  OverviewViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

protocol reloadFocusDelegate {
    
    func reloadFocusAfterSave()
    
}

class OverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    //MARK: variables
    var taskID : UUID?
    var newTaskSessions : [(Date,Int)]?
    var task = Task()
    var endTime : Date?
    var bgColor : UIColor?
    var goalColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    var taskImage : UIImage?
    var newNotes : [String]?
    var tagList : [String]?
    var reloadDelegate : reloadFocusDelegate?

    //MARK: IB Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskIconView: TaskIcon!
    @IBOutlet weak var overviewTableLabel: UILabel!
    @IBOutlet weak var overviewTable: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    //MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.overviewTable.delegate = self
        self.overviewTable.dataSource = self
        
        self.view.backgroundColor = self.bgColor
        
        // make sure id is UUID
        guard let id = self.taskID else {
            print("id not UIID")
            return
        }
        
        // fetch task from UUID
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        
        do {
            let taskFromID =  try PersistenceService.context.fetch(fetchRequest)[0]
            self.task = taskFromID
            self.tagList = taskFromID.tags
            print(taskFromID.taskDatesAndDurations)
            
        } catch {
            
            print("Oh no, there is no data to load")
        }
        
        // set up previous sessions


        
        // set up buttons
        setUpColors()
        if let image = taskImage {
            taskIconView.iconSetup(icon: image, iconColor: goalColor)
        }
        taskNameLabel.text = task.name

    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return newTaskSessions!.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let unsavedSessions = newTaskSessions else {
            return tableView.dequeueReusableCell(withIdentifier: "unsavedSession") as! PreviousSessionCell
        }
        
        let row = indexPath.row
        if indexPath.section == 0 {
            let startEndCell = tableView.dequeueReusableCell(withIdentifier: "startEndCell") as! StartEndCell
            startEndCell.configure(startDate: unsavedSessions.last!.0, endDate: self.endTime ?? Date(), color: goalColor)
            startEndCell.tintColor = goalColor
            return startEndCell
        }
        else {
            let unsavedCell = tableView.dequeueReusableCell(withIdentifier: "unsavedSession") as! PreviousSessionCell
            unsavedCell.configure(with: unsavedSessions[row].0, duration: unsavedSessions[row].1, color: goalColor)
            unsavedCell.tintColor = goalColor
            return unsavedCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 2.0
        } else {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        if section == 0 {
            view.tintColor = goalColor
        }

    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let addNote = UITableViewRowAction(style: .normal, title: "Add Note") { (action, indexPath) in
            // edit item at indexPath
            let sessionCell = tableView.cellForRow(at: indexPath) as! PreviousSessionCell
            
            guard let date = self.newTaskSessions?[indexPath.row].0 else {
                return
            }
            
            let dateString = self.formatDateForNote(date: date)
            
            guard let duration = sessionCell.sessionDurationLabel.text else {
                return
            }
            
            self.insertNewNote(date: dateString, duration: duration)
            if self.saveButton.isEnabled {
                sessionCell.accessoryType = .checkmark
            }
        }
        
        addNote.backgroundColor = goalColor
        
        return [addNote]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        else{
            return true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y<=0) {
            scrollView.contentOffset = CGPoint.zero;
        }
    }
    
    
    
    // MARK: - Collection View
    
    
    
    // MARK: - Navigation
    
    @IBAction func cancelPressed(_ sender: Any) {
        
        if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
             dismiss(animated: true, completion: nil)
        }
    }

    
    //MARK: - Private Functions
    
    private func saveState() {
        
        task.tags = tagList
        print(newNotes)
        if let notes = newNotes {
            if let taskNotes = task.notes {
                task.notes = taskNotes + notes
            }else {
                task.notes = notes
            }
        }
        
        if var previousSessions = task.taskDatesAndDurations {
            
            for session in self.newTaskSessions! {
                previousSessions[session.0] = session.1
                print(session.1)
            }
            task.taskDatesAndDurations = previousSessions
        } else {
            for session in self.newTaskSessions! {
                task.taskDatesAndDurations = [:]
                task.taskDatesAndDurations?[session.0] = session.1
            }
        }
        print(task.notes)
        PersistenceService.saveContext()
    }
    
    private func setUpColors() {
        
        overviewTable.layer.borderWidth = 5
        overviewTable.layer.borderColor = goalColor.cgColor
        overviewTable.layer.cornerRadius = 15.0
        
        overviewTableLabel.layer.borderWidth = 2
        overviewTableLabel.layer.borderColor = goalColor.cgColor
        overviewTableLabel.textColor = goalColor
        
        taskNameLabel.textColor = goalColor
        
        let tintedSave = saveButton.imageView?.image!.withRenderingMode(.alwaysTemplate)
        saveButton.setImage(tintedSave, for: .normal)
        saveButton.tintColor = goalColor
        
    }
    
    private func formatDateForNote(date:Date) -> String {
        
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let dateMatch : String
        
        RFC3339DateFormatter.dateFormat = "MMM d, h:mm a"
        RFC3339DateFormatter.timeZone = TimeZone.current
        dateMatch = RFC3339DateFormatter.string(from: date)
        
        return dateMatch
    }
    
    private func formatAlertController(alertController: UIAlertController) {
        alertController.view.tintColor = goalColor
        alertController.view.layer.borderWidth = 3
        alertController.view.layer.borderColor = goalColor.cgColor
        alertController.view.layer.cornerRadius = 15.0
        alertController.view.clipsToBounds = true
        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    private func formatAlertText(alertController: UIAlertController, text: String, size: CGFloat, font: String, forKey: String) {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont(name: font, size: size)!, NSAttributedString.Key.foregroundColor : goalColor])
        alertController.setValue(myMutableString, forKey: forKey)
    }
    
    //MARK: - Actions
    
    

    @IBAction func savePressed(_ sender: Any) {
        
        saveState()
        
        if reloadDelegate != nil {
            reloadDelegate?.reloadFocusAfterSave()
            saveButton.isEnabled = false
        }
        
    }
    
    let textView = UITextView(frame: CGRect.zero)
    
    func insertNewNote(date: String, duration: String) {
        
        let messageString = "Note for: \n" + date + " (" + duration + ")"
        // Get information from user and configure object
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n", message:  messageString, preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            // Do whatever you want with inputTextField?.text
            let savedNote = date + " (" + duration + ")" + " - " + self.textView.text
            if let notes = self.newNotes {
                let allNotes = notes + [savedNote]
                self.newNotes = allNotes
            } else {
                self.newNotes = [savedNote]
            }
            
            self.saveButton.isEnabled = true
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        })
        
        save.isEnabled = false

        
        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: textView, queue: OperationQueue.main) { (notification) in
            save.isEnabled = self.textView.text != ""
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        
        alertController.addTextField { field in
            field.translatesAutoresizingMaskIntoConstraints = false
            field.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        let inCntrlr =  alertController.children[0].view!
        inCntrlr.removeFromSuperview()
        
        formatAlertController(alertController: alertController)
        formatAlertText(alertController: alertController, text: messageString, size: 16, font: "AvenirNext-Bold", forKey: "attributedMessage")
        
        self.textView.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
        self.textView.backgroundColor = self.bgColor
        self.textView.textColor = goalColor
        self.textView.layer.borderWidth = 3
        self.textView.layer.borderColor = goalColor.cgColor
        self.textView.layer.cornerRadius = 15.0
        
        alertController.view.addSubview(self.textView)
        alertController.addAction(save)
        alertController.addAction(cancel)

        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        present(alertController, animated: true)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin:CGFloat = 10.0
                textView.frame = CGRect.init(x: rect.origin.x + margin, y: rect.origin.y + margin, width: rect.width - 2*margin, height: rect.height / 2)
                textView.bounds = CGRect.init(x: rect.origin.x + margin, y: rect.origin.y + margin, width: rect.width - 2*margin, height: rect.height / 2)
            }
        }
    }
    

    
}
