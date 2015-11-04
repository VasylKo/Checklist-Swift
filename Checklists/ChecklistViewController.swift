//
//  ViewController.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/2/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var row0text = "Walk the dog"
    var row1text = "Brush teeth"
    var row2text = "Learn iOS development"
    var row3text = "Soccer practice"
    var row4text = "Eat ice cream"
    
    var row0checked = false
    var row1checked = false
    var row2checked = false
    var row3checked = false
    var row4checked = false
    
    
    
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
            text = row0text
        } else if indexPath.row == 1 {
            text = row1text
        } else if indexPath.row == 2 {
            text = row2text
        } else if indexPath.row == 3 {
            text = row3text
        } else if indexPath.row == 4 {
            text = row4text
        }
        
        label.text = text
        configureCheckmarkForCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    //MARK: - Table View data delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Set checkmark
        /*
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .None {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
*/
        if let cell = tableView.cellForRowAtIndexPath(indexPath) { if indexPath.row == 0 {
            row0checked = !row0checked
        } else if indexPath.row == 1 { row1checked = !row1checked
        } else if indexPath.row == 2 { row2checked = !row2checked
        } else if indexPath.row == 3 { row3checked = !row3checked
        } else if indexPath.row == 4 { row4checked = !row4checked
            }
           
        configureCheckmarkForCell(cell, indexPath: indexPath) }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
            var isChecked = false
            if indexPath.row == 0 { isChecked = row0checked
        } else if indexPath.row == 1 { isChecked = row1checked
        } else if indexPath.row == 2 { isChecked = row2checked
        } else if indexPath.row == 3 { isChecked = row3checked
        } else if indexPath.row == 4 { isChecked = row4checked
            }
            if isChecked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
            } }

}

