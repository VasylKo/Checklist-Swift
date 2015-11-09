//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/4/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
    //git test
    func gitTest() {
        print("Git test")
    }
    
    func gitTestNewBranchInDeveloper() {
        print("Git test")
    }
}


