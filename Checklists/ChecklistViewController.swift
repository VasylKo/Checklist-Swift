//
//  ViewController.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/2/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View data source protocol
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        //Get label
        let label = cell.viewWithTag(1000) as! UILabel
        var text = ""
        
        if indexPath.row == 0 {
            text = "Walk the dog"
        } else if indexPath.row == 1 {
            text = "Brush my teeth"
        } else if indexPath.row == 2 {
            text = "Learn iOS developmnet"
        } else if indexPath.row == 3 {
            text = "Socer practice"
        } else if indexPath.row == 4 {
            text = "Eat ice cream"
        }
        
        label.text = text
        
        return cell
    }
    
    //MARK: - Table View data delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

}

