//
//  ViewController.swift
//  StorageStructure
//
//  Created by kooapps on 4/19/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SetPListIntheDataContainer();
    }
    
    func SetPListIntheDataContainer() {
        print(NSHomeDirectory())
        let path = NSHomeDirectory() + "/Documents/myPlist.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let color = plist["Color"] {
                print("The Color is \(color)")
            }
            
            plist["Color"] = "Green"
            
            if plist.write(toFile: path, atomically: true) {
                print("adjust finish")
            }
        }
    }
    
    func SetSqlite() {
        query()
    }
    
    func insert () {
        
    }
    
    func query () {
        let app = UIApplication.shared.delegate as! AppDelegate
        if let db = app.db {
            let tmp = "lee".cString(using: .utf8)
            let sql = "SELECT * FROM UserData WHERE cname = ?"
            var statement: OpaquePointer? = nil
            
            if sqlite3_prepare(db, sql, -1, &statement, nil) != SQLITE_OK {
                printerr(db)
            }
            
            if sqlite3_bind_text(statement, 1, tmp, -1, nil) != SQLITE_OK {
                printerr(db)
            }
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let iid = sqlite3_column_text(statement, 0)
                let cname = sqlite3_column_text(statement, 1)
                
                if iid != nil {
                    let iids = String(cString: iid!)
                    print("acc: \(iid)")
                }
                
                if cname != nil {
                    let cnameS = String(cString: cname!)
                    print("name: \(cnameS)")
                }
            }
            
            sqlite3_finalize(statement)
            
        }
    }
    
    func printerr (_ db: OpaquePointer) {
        let errMsg = String(cString: sqlite3_errmsg(db))
        print("prepare error: \(errMsg)")
    }

}

