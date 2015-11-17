//
//  ViewController.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/2/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import UIKit


class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

    var items: [ChecklistItem]
    var checklist: Checklist!

    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        super.init(coder: aDecoder)
        
        loadChecklistItems()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = checklist.name
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        items.removeAtIndex(indexPath.row)
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        saveChecklistItems()
    }
    
    //MARK: - Table View delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        saveChecklistItems()
    }
    
    //MAKR: - Configurate cells
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    func configurateTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
                    let label = cell.viewWithTag(1000) as! UILabel
                    label.text = item.text
    }
    
    

    //MAKR: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }

    
    //MARK: - ItemDetailViewControllerDelegate
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        if let index = items.indexOf(item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0);
            
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configurateTextForCell(cell, withChecklistItem: item)
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        saveChecklistItems()
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = NSIndexPath(forItem: newRowIndex, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
        saveChecklistItems()
    }
    
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - Save file to file system
    func documnetsDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return path[0]
    }
    
    func dataFilePath () -> String {
        return (documnetsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
    }

    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(items, forKey: "CheckListItems")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChecklistItems() {
        
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                items = unarchiver.decodeObjectForKey("CheckListItems") as! [ChecklistItem]
                unarchiver.finishDecoding()
                
            }
        }
        
    }
}

