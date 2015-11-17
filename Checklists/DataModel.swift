//
//  DataModel.swift
//  Checklists
//
//  Created by Vasyl Kotsiuba on 11/17/15.
//  Copyright © 2015 Vasyl Koysiuba. All rights reserved.
//

import Foundation


class DataModel {
    var lists = [Checklist]()
    
    
    init () {
        loadChecklists()
    }
    
    //MARK: - Save file to file system
    func documnetsDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return path[0]
    }
    
    func dataFilePath () -> String {
        return (documnetsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "CheckLists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("CheckLists") as! [Checklist]
                unarchiver.finishDecoding()
                
            }
        }
        
    }

}