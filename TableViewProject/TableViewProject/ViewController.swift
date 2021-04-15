//
//  ViewController.swift
//  TableViewProject
//
//  Created by kooapps on 4/15/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list = [
        ("Sunrise", "爬山", "天氣良好的運動", true),
        ("Snow", "滑雪", "冬天的運動", false),
        ("Bicyclwe", "單車", "休閒的運動", true),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "uUpdating.....")
        
    }
    
    @objc func handleRefresh() {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh:mm:ss"
        let time = formatter.string(from:  Date())
        list.append( ("time", "時間", time, true))
        
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    
    @IBAction func onClick(_ sender: Any) {
        if let indexPath = tableView.indexPathForSelectedRow {
            print("2. \(list[indexPath.row].1)")
        }
        
        tableView.isEditing = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCell
        
//        cell.imageView?.image = UIImage(named: "\(indexPath.row + 1).png")
//        cell.textLabel?.text = list[indexPath.row].1
//        cell.detailTextLabel?.text = list[indexPath.row].2
        cell.label.text = list[indexPath.row].1
        cell.favoriteSwitch.isOn =  list[indexPath.row].3
        
        
        print(indexPath)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(list[indexPath.row].1)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        list.insert(list.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
        
        for item in list {
            print("\(item)")
        }
        
        print("-------------")
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "蛤！刪除？"
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let go  = UIContextualAction(style: .normal, title: "more") { (action, view, completionHandler) in completionHandler(true)
            
        }
        
        go.backgroundColor = .blue
        
        let del = UIContextualAction(style: .destructive, title: "deldete") { (action, view, completionHandler) in completionHandler(true)
            
        }
        
        del.backgroundColor = .systemPink
        
        let config = UISwipeActionsConfiguration(actions: [go, del])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "footer"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}

