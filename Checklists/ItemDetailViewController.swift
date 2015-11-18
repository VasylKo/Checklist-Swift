//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/4/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import Foundation
import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}


class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit item"
            textField.text = item.text
            doneButton.enabled = true
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    @IBAction func cancel(sender: AnyObject) {
        delegate?.itemDetailViewControllerDidCancel(self)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func done(sender: AnyObject) {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
            
        } else {
            let item = ChecklistItem(text: textField.text!, checked: false)
//            item.text = textField.text!
//            item.checked = false
            
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
        
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //MARK: - Text Field Delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldTExt: NSString = textField.text!
        let newText: NSString = oldTExt.stringByReplacingCharactersInRange(range, withString: string)
        
        
        doneButton.enabled = newText.length > 0
        
        return true
    }
}