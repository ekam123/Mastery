//
//  DetailedViewController.swift
//  testing
//
//  Created by Ekam Singh Dhaliwal on 2019-07-22.
//  Copyright © 2019 ekam-singh. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var goal: Plan?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let goal = goal else {
            return
        }
        print(goal)
        
        print(goal.tasks!)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
