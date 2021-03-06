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
    var indexOfSelectedChecklist: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        }
        
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    init () {
        loadChecklists()
        registerDEfaults()
        handleFirstTime()
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
                
                sortChecklists()
            }
        }
        
    }
    
    //MARK: - Helper methods
    func registerDEfaults() {
        let dic = ["ChecklistIndex" : -1,
                    "FirstTime" : true]
        NSUserDefaults.standardUserDefaults().registerDefaults(dic)
    }
    
    func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.boolForKey("FirstTime") {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0
            userDefaults.setInteger(0, forKey: "ChecklistIndex")
            userDefaults.setBool(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
    func sortChecklists() {
        lists.sortInPlace ({ (checklist1, checklist2) -> Bool in
            checklist1.name.localizedStandardCompare(checklist2.name) == .OrderedAscending
        })
    }
    
}