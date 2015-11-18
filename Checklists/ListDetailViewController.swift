//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/17/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var iconImageView: UIImageView!
    
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
    var iconName = "Folder"
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.enabled = true
            iconName = checklist.iconName
    
        }
        
        iconImageView.image = UIImage(named: iconName)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    //MARK: - Actions
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
    
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            checklist.iconName = iconName
            delegate?.listDetailViewController(self, didFinishEditingChecklist: checklist)
    
        } else {
            let checklist = Checklist(name: textField.text!)
            checklist.iconName = iconName
            delegate?.listDetailViewController(self, didFinishAddingChecklist: checklist)
        }
    }
    
    //MARK: - Table view delegate
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    //MARK: - Text field delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString:string)
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
    
    //MARK: - IconPickerViewControllerDelegate
    func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String) {
        self.iconName = iconName
        iconImageView.image = UIImage(named: iconName)
        navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - Navigarion
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickIcon" {
            let controller = segue.destinationViewController as! IconPickerViewController
            controller.delegate = self
        }
    }
   

}
