//
//  MasterTableViewController.swift
//  MasteryTableViewTest
//
//  Created by Cameron Mcleod on 2019-07-22.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import UIKit
import os.log

class MasterTableViewController: UITableViewController {
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        user = loadSampleUser()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return user!.goalList!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        let goalID = user!.goalList![indexPath.row]
        // Configure the cell...
        let goal = user?.allElements[goalID] as! Goal
        cell.textLabel!.text = goal.name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let detail = segue.destination as? DetailViewController{
            
            switch(segue.identifier ?? "") {
                
            case "editDetail":
                
                if let cell = sender as? UITableViewCell {
                    os_log("editing detail", log: OSLog.default, type: .debug)
                    detail.name = cell.textLabel!.text!
                    detail.user = user
                    let goalID = self.user?.goalList![self.tableView.indexPath(for: cell)!.row]
                    detail.goal = self.user?.allElements[goalID!] as? Goal
                    
                    detail.completionHandler = { goal in
                        self.user?.allElements[goal.id] = goal
                        self.tableView.reloadData()

                    }
                }
                
            case "addDetail":
                os_log("new detail", log: OSLog.default, type: .debug)
//                detail.name = ""
//                detail.completionHandler = { name in
//                    self.names.append(name)
//                    self.tableView.reloadData()
//                }
                
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            }
        }
        
        
           
            
        }

}
