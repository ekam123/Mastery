//
//  FocusViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class FocusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, reloadFocusDelegate {
    
    //MARK: - Variables
    enum CurrentMode {
        case focusMode
        case breakMode
    }
    
    var taskID : UUID?
    var task = Task()
    var taskPredicate: NSPredicate?
    var goalColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    
    let FOCUS_TIME = UserDefaults.standard.integer(forKey: "focusTime")
    let BREAK_TIME = UserDefaults.standard.integer(forKey: "breakTime")
    var currentCounter = 10
    var timer = Timer()
    var isTimerRunning = false
    var hasStarted = false
    var currentMode = CurrentMode.focusMode
    var taskSessions: [(Date,Int)] = []
    var newTaskSessions: [(Date,Int)] = []
    var sessionStartTime = Date()
    var fromBreak = false
    
    //MARK: - UI Outlets
    
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTimerView: TaskIcon!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var previousSessionsTable: UITableView!
    @IBOutlet weak var playButton: PausePlayButton!
    @IBOutlet weak var pauseButton: PausePlayButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var previousSessionsLabel: UILabel!
    @IBOutlet weak var sneakyWizard: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseByResign), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(returnToApp), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        // Do any additional setup after loading the view.
        self.previousSessionsTable.delegate = self
        self.previousSessionsTable.dataSource = self
        
        currentCounter = FOCUS_TIME
        
        // make sure id is UUID
        guard let id = self.taskID else {
            print("id not UIID")
            return
        }
        
        // fetch task from UUID
        fetchDataAndSessions(id: id)
        
        // set up buttons
        setUpButtons()
        
        setUpColors()
        
        self.previousSessionsTable.reloadData()
        
        // set up notifications
        let breakOverNotifCategory = UNNotificationCategory(identifier: "breakOverNotification", actions: [], intentIdentifiers: [], options: [])
        // #1.2 - Register the notification type.
        UNUserNotificationCenter.current().setNotificationCategories([breakOverNotifCategory])
        
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return newTaskSessions.count
        } else {
            return taskSessions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "previousSession") as! PreviousSessionCell
        let row = indexPath.row
        
        if indexPath.section == 1 {
            cell.configure(with: taskSessions[row].0, duration: taskSessions[row].1, color: goalColor)
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.configure(with: newTaskSessions[row].0, duration: newTaskSessions[row].1, color: goalColor)
        }
        cell.tintColor = goalColor
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y<=0) {
            scrollView.contentOffset = CGPoint.zero;
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        if newTaskSessions.count > 0 {
            
            let message  = "If you cancel now, your new sessions will not save. Do you want to still cancel?"
            let alertController = UIAlertController(title: task.name, message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "No", style: .cancel))
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
                self.dismiss(animated:true)
            }))
            
            formatAlertController(alertController: alertController)
            formatAlertText(alertController: alertController, text: self.taskNameLabel.text!, size: 22, font: "AvenirNext-Bold", forKey: "attributedTitle")
            formatAlertText(alertController: alertController, text: message, size: 18, font: "AvenirNext-Regular", forKey: "attributedMessage")
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.dismiss(animated:true)
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        UIApplication.shared.isIdleTimerDisabled = false
        if segue.identifier == "finishSession" {
        
            let overviewVC = segue.destination as! OverviewViewController
            overviewVC.newTaskSessions = newTaskSessions
            overviewVC.taskID = taskID
            overviewVC.endTime = Date()
            overviewVC.bgColor = self.view.backgroundColor
            overviewVC.reloadDelegate = self
            overviewVC.goalColor = goalColor
            overviewVC.taskImage = taskTimerView.iconImage.image
            
            
        }
    }
    
    @objc func pauseByResign() {
        
        switch currentMode {
            
        case .focusMode:
            
            if isTimerRunning {
                startStopTimer()
            }
            
        case .breakMode:
            
            // add local notification in case user does not return in time after break and store time to decrement counter
            UserDefaults.standard.set(Date(), forKey:"LastResignDate")
            sendNotification(triggerTime: currentCounter)
            
            return
            
        }
    }
    
    @objc func returnToApp() {
        
        switch currentMode {
            
        case .focusMode:
            
            return
            
        case .breakMode:
            
            // remove local notification if user is returning before break is over
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            center.removeAllDeliveredNotifications()
            // decrement counter to reflect time away from app
            let dateResigned = UserDefaults.standard.object(forKey: "LastResignDate") as! Date
            let timeGone = Date().timeIntervalSince(dateResigned) - 1.0 //subtract 1 to account for app load and unload while counter is still firing
            currentCounter = currentCounter > Int(timeGone) ? currentCounter - Int(timeGone) : 1
            
        }
        
    }
    
    // MARK: - Private Functions
    
    private func fetchDataAndSessions(id: UUID) {
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        
        do {
            let taskFromID =  try PersistenceService.context.fetch(fetchRequest)[0]
            self.task = taskFromID
            
        } catch {
            
            print("Oh no, there is no data to load")
        }
        
        // set up previous sessions
        if let sessions = task.taskDatesAndDurations {
            self.taskSessions = sortSessionsByDate(sessions: sessions)
        }
        
        // set up image and color scheme
        goalColor = task.goal!.color!
        
        if let imageData = task.image {
            taskTimerView.iconSetup(icon: UIImage(data: imageData as Data), iconColor: goalColor)
        }
        
    }

    
    private func startStopTimer () {
        
        animatePausePlay(isRunning: isTimerRunning)
        
        if !hasStarted {
            hasStarted = true
            UIApplication.shared.isIdleTimerDisabled = true
            UserDefaults.standard.set(Date(), forKey:"TaskStartTime")
            sessionStartTime = UserDefaults.standard.object(forKey: "TaskStartTime") as! Date
        }
        
        switch isTimerRunning {
        case false:
            isTimerRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        case true:
            isTimerRunning = false
            timer.invalidate()

        }
        
        animateTimer()
        
        switch currentMode {
        case .breakMode:
            if currentCounter == BREAK_TIME {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.taskTimerView.taskRing.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    self.taskTimerView.taskRing.alpha = 0
                    self.taskTimerView.iconImage.alpha = 0.65
                }) { (Bool) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.taskTimerView.taskRing.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.taskTimerView.taskRing.alpha = 1.0
                        self.taskTimerView.iconImage.alpha = 0.30
                    })
                    
                }
                
            } else {
                taskTimerView.animate()
            }
        case .focusMode:
            if currentCounter == FOCUS_TIME {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.taskTimerView.taskRing.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    self.taskTimerView.taskRing.alpha = 0
                    self.taskTimerView.iconImage.alpha = 0.65
                }) { (Bool) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.taskTimerView.taskRing.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.taskTimerView.taskRing.alpha = 1.0
                        self.taskTimerView.iconImage.alpha = 0.30
                    })
                    
                }
                
            } else {
                taskTimerView.animate()
            }
        }
    }
    
    @objc private func updateTimer() {
        
        if currentCounter > 0 {
            currentCounter = currentCounter - 1
            timerLabel.text = currentCounter.secondsToHoursMinutesSeconds()
            switch currentMode {
            case .focusMode:

                let amtComplete = CGFloat(FOCUS_TIME-currentCounter) / CGFloat(FOCUS_TIME)
                taskTimerView.iconImage.alpha = amtComplete * 0.7 + 0.3
                taskTimerView.redrawRing(completion: amtComplete)
                
            case .breakMode:
                
                let amtComplete = CGFloat(BREAK_TIME-currentCounter) / CGFloat(BREAK_TIME)
                taskTimerView.iconImage.alpha = amtComplete * 0.7 + 0.3
                taskTimerView.redrawRing(completion: amtComplete)
                
            }
            
        } else {
            
            startStopTimer()
            taskTimerView.iconImage.alpha = 1
            
            UIView.animate(withDuration: 1.0) {
                    self.taskTimerView.taskRing.alpha = 1
            }
            taskTimerView.taskRing.layer.mask = nil
            taskTimerView.animate()
            switch currentMode {
                
            case .focusMode:
                self.currentCounter = BREAK_TIME
                self.timerLabel.text = self.currentCounter.secondsToHoursMinutesSeconds()
                currentMode = .breakMode
                animateBackgroundColor(toColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                popFocusDoneAlert()
                
            case .breakMode:
                currentCounter = FOCUS_TIME
                animateBackgroundColor(toColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                timerLabel.text = self.currentCounter.secondsToHoursMinutesSeconds()
                hasStarted = false
                fromBreak = true
                popStartingAlert()
                self.pauseButton.isEnabled = true
                currentMode = .focusMode
                
            }
        }

    }
    
    
    //MARK: - Alerts
    
    @objc func popStartingAlert() {
        if !hasStarted {
            var alertTitle : String?
            if fromBreak {
                alertTitle = "Break Over"
                fromBreak = false
            } else {
                alertTitle = task.name
            }
            let message  = "Are you ready to start a new session?"
            let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "No", style: .cancel))
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
                self.finishButton.isEnabled = false
                self.hasStarted = true
                self.sessionStartTime = Date()
                self.startStopTimer()
            }))
            
            formatAlertController(alertController: alertController)
            formatAlertText(alertController: alertController, text: alertTitle!, size: 22, font: "AvenirNext-Bold", forKey: "attributedTitle")
            formatAlertText(alertController: alertController, text: message, size: 18, font: "AvenirNext-Regular", forKey: "attributedMessage")

            self.present(alertController, animated: true, completion: nil)
            
        } else {
            startStopTimer()
        }
    }
    

    
   func popFocusDoneAlert() {
    
        let message  = "Session Complete! Take a mandatory break or press Finish to save session."
        let alertController = UIAlertController(title: task.name, message: message, preferredStyle: .alert)
    
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            
            self.pauseButton.isEnabled = false
            self.finishButton.isEnabled = true
            self.previousSessionsTable.beginUpdates()
            self.newTaskSessions.insert((self.sessionStartTime,self.FOCUS_TIME), at: 0)
            self.previousSessionsTable.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            self.previousSessionsTable.endUpdates()
            self.startStopTimer()
            
        }))
    
        formatAlertController(alertController: alertController)
        formatAlertText(alertController: alertController, text: self.taskNameLabel.text!, size: 22, font: "AvenirNext-Bold", forKey: "attributedTitle")
        formatAlertText(alertController: alertController, text: message, size: 18, font: "AvenirNext-Regular", forKey: "attributedMessage")
    
        self.present(alertController, animated: true, completion: nil)
    
    }

    
    func formatAlertController(alertController: UIAlertController) {
        alertController.view.tintColor = goalColor
        alertController.view.layer.borderWidth = 3
        alertController.view.layer.borderColor = goalColor.cgColor
        alertController.view.layer.cornerRadius = 15.0
        alertController.view.clipsToBounds = true
        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func formatAlertText(alertController: UIAlertController, text: String, size: CGFloat, font: String, forKey: String) {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont(name: font, size: size)!, NSAttributedString.Key.foregroundColor : goalColor])
        alertController.setValue(myMutableString, forKey: forKey)
    }
    
    // MARK: - Setup and Ops
    
    private func setUpColors() {
        
        previousSessionsTable.layer.borderWidth = 5
        previousSessionsTable.layer.borderColor = goalColor.cgColor
        previousSessionsTable.layer.cornerRadius = 15.0
        
        previousSessionsLabel.layer.borderWidth = 2
        previousSessionsLabel.layer.borderColor = goalColor.cgColor
        
        taskNameLabel.textColor = goalColor
        timerLabel.textColor = goalColor
        let tintedPlay = playButton.imageView?.image!.withRenderingMode(.alwaysTemplate)
        playButton.setImage(tintedPlay, for: .normal)
        playButton.tintColor = goalColor
        
        let tintedPause = pauseButton.imageView?.image!.withRenderingMode(.alwaysTemplate)
        pauseButton.setImage(tintedPause, for: .normal)
        pauseButton.tintColor = goalColor
        
        let tintedFinish = finishButton.imageView?.image!.withRenderingMode(.alwaysTemplate)
        finishButton.setImage(tintedFinish, for: .normal)
        finishButton.tintColor = goalColor
        
        previousSessionsLabel.textColor = goalColor
    
    }

    
    private func setUpButtons () {
        
        
        resetButtons()
        
        self.playButton.addTarget(self, action: #selector(popStartingAlert), for: .touchDown)
        self.pauseButton.addTarget(self, action: #selector(popStartingAlert), for: .touchDown)
        
    }
    
    private func resetButtons () {
        
        
        
        self.playButton.isHidden = false
        self.pauseButton.isHidden = true
        
        self.taskNameLabel.text = self.task.name
        
        self.timerLabel.text = FOCUS_TIME.secondsToHoursMinutesSeconds()
    
        self.finishButton.isEnabled = false
        
    }
    
    private func resetToFocusMode() {
        
        currentMode = .focusMode
        currentCounter = FOCUS_TIME
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timer.invalidate()
        isTimerRunning = false
        hasStarted = false
        fromBreak = false
        
    }
    
    private func sortSessionsByDate (sessions:[Date:Int]) ->[(Date,Int)] {
        
        return sessions.sorted { (arg0, arg1) -> Bool in
            
            let (key2, _) = arg1
            let (key1, _) = arg0
            
            return key1.timeIntervalSince(key2) > 0
        }
    }
    
    private func sendNotification(triggerTime: Int) {
        
        // find out what are the user's notification preferences
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            
            guard settings.authorizationStatus == .authorized else { return }
            
            let content = UNMutableNotificationContent()
            
            content.categoryIdentifier = "breakOverNotification"
            
            content.title = "\(self.task.name!) break is over!"
            content.body = "Swipe right to return to Mastery."
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(triggerTime), repeats: false)
            
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
        
    }
    
    // MARK: - Animations
    
    private func animatePausePlay(isRunning: Bool) {
        
        switch isRunning {
        case false:
            self.playButton.isHidden = true
            self.pauseButton.isHidden = false
            self.pauseButton.animatePlayPause()
        case true:
            self.playButton.isHidden = false
            self.pauseButton.isHidden = true
            self.playButton.animatePlayPause()
        }
    }
    
    func animateTimer() {
        
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.1
        pulseAnimation.repeatCount = 1
        
        let startScale: Float = 0.4
        let stopScale: Float = 1.0
        
        pulseAnimation.fromValue = NSNumber(value: startScale as Float)
        pulseAnimation.toValue = NSNumber(value: stopScale as Float)
        pulseAnimation.autoreverses = true
        pulseAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = self.timerLabel.layer
        layer.add(pulseAnimation, forKey:"pulseLabel")
    }
    
    func animateBackgroundColor(toColor: UIColor) {
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.view.backgroundColor = toColor
        })
        
    }
    //MARK: reload Delegate
    
    func reloadFocusAfterSave() {
        
        resetButtons()
        resetToFocusMode()
        taskTimerView.iconImage.alpha = 1.0
        taskTimerView.taskRing.layer.mask = nil
        newTaskSessions = []
        taskSessions = []
        fetchDataAndSessions(id: task.id!)
        previousSessionsTable.reloadData()

        
    }
    
    @IBAction func sneakyWizardButton(_ sender: UIButton) {
        currentCounter = 5
    }
    

}

