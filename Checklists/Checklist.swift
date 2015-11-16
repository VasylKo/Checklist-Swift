//
//  Checklist.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/16/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}

