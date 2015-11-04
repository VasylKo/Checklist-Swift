//
//  ViewController.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/2/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var items: [ChecklistItem]
    

    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
           
        let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        
        let row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        
        super.init(coder: aDecoder)
    }
    
    
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
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
            let item = items[indexPath.row]
            
            configurateTextForCell(cell, withChecklistItem: item)
            configureCheckmarkForCell(cell, withChecklistItem: item)
            
            return cell
    }
    
    //MARK: - Table View data delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MAKR: - Configurate cells
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
         
            if item.checked {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
    }
    
    func configurateTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
                    let label = cell.viewWithTag(1000) as! UILabel
                    label.text = item.text
    }

    //MAKR: - Actions
    
    @IBAction func addIten() {
                        
                        let newRowIndex = items.count
                        let item = ChecklistItem()
                        item.text = "I am a new row"
                        item.checked = false
                        
                        items.append(item)
                        
                        let indexPath = NSIndexPath(forItem: newRowIndex, inSection: 0)
                        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }


}

