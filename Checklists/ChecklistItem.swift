//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/4/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text: String = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
        
    }
    
    init(text: String,  checked: Bool) {
        self.text = text
        self.checked = checked
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    

}


