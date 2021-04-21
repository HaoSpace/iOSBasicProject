//
//  ViewController.swift
//  DesignCoreData
//
//  Created by kooapps on 4/21/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let app = UIApplication.shared.delegate as! AppDelegate
    lazy var context = app.persistentContainer.viewContext
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(NSPersistentContainer.defaultDirectoryURL())
//        insertUserData()
//        queryUserData()
        
//        queryWithPredicate()
//        storedFetch()
//        storedFetchWithArgument()
        
//        deleteUserData()
//        queryUserData()
        
//        insertOneToMany()
//        query_oneToMany()
        
//        saveImage()
//        loadImage()
        
        saveData()
        loadData()
        
    }
    
    func insertUserData() {
        let u1 = UserData(context: context)
        u1.iid = "A01"
        u1.cname = "Ming"
        
        let u2 = UserData(context: context)
        u2.iid = "A02"
        u2.cname = "Lee"
        
        app.saveContext()
    }
    
    func queryUserData () {
        do {
            let users = try context.fetch(UserData.fetchRequest())
            for user in users as! [UserData]{
                print("\(user.iid!), \(user.cname!)")
            }
            
        } catch
        {
            print(error.localizedDescription)
        }
    }
    
    func queryWithPredicate() {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        let predicate = NSPredicate(format: "cname like 'M*'")
        fetchRequest.predicate = predicate
        
        let sort = NSSortDescriptor(key: "iid", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let users = try context.fetch(fetchRequest)
            for user in users {
                print("\(user.iid!), \(user.cname!)")
            }
        } catch {
            print(error)
        }
    }
    
    func storedFetch (){
        let model = app.persistentContainer.managedObjectModel
        let fetchRequest = model.fetchRequestTemplate(forName: "Fetch_iid_is_A01")
        
        do {
            let users = try context.fetch(fetchRequest!)
            for user in users as! [UserData] {
                print("\(user.iid!), \(user.cname!)")
            }
        } catch {
            print(error)
        }
    }
    
    func storedFetchWithArgument (){
        let model = app.persistentContainer.managedObjectModel
        let fetchRequest = model.fetchRequestFromTemplate(withName: "Fetch_by_cname", substitutionVariables: ["CNAME": "L"])
        
        do {
            let users = try context.fetch(fetchRequest!) as! [UserData]
            
            for user in users {
                print("\(user.iid!), \(user.cname!)")
            }
        } catch {
            print(error)
        }
    }
    
    func deleteUserData() {
        let coord = app.persistentContainer.persistentStoreCoordinator
        let batch = NSBatchDeleteRequest(fetchRequest: UserData.fetchRequest())
        
        do {
            try coord.execute(batch, with: context)
            print("remove success")
        } catch {
            print(error)
        }
    }
    
    func insertOneToMany () {
        let user = UserData(context: context)
        user.iid = "A03"
        user.cname = "Wang"
        
        let car1 = Car(context: context)
        car1.plate = "AA-0001"
        
        let car2 = Car(context: context)
        car2.plate = "BB-0001"
        
        user.addToOwn(car1)
        user.addToOwn(car2)
        
        app.saveContext()
    }
    
    func query_oneToMany (){
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        let predicate = NSPredicate(format: "iid = 'A03'")
        fetchRequest.predicate = predicate
        
        do {
            let users = try context.fetch(fetchRequest)
            
            for user in users {
                if user.own == nil {
                    print("no car")
                } else {
                    print("\(user.cname!) have \(user.own!.count) cars")
                    
                    for car in user.own as! Set<Car> {
                        print("car is \(car.plate!)")
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func saveImage () {
        let image = UIImage(named: "1.png")
        let user = UserData(context: context)
        user.iid = "A04"
        user.cname = "mai"
        user.image = image?.pngData()
        
        app.saveContext()
    }
    
    func loadImage () {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        let predicate = NSPredicate(format: "iid = 'A04'")
        fetchRequest.predicate = predicate
        
        do {
            let users = try context.fetch(fetchRequest)
            
            for user in users {
                print("User: \(user.cname!)")
                if let image = user.image {
                    
                    let imageView = UIImageView()
                    imageView.frame = view.bounds
                    imageView.contentMode = .scaleAspectFill
                    view.addSubview(imageView)
                    
                    imageView.image = UIImage(data: image)
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    func saveData () {
        let photo = [Photo()]
        photo[0].image = UIImage(named: "1.png")
        photo[0].title = "doggy"
        
        let entity = PhotoEntity(context: context)
        entity.photoObject = photo as! NSObject
        
        app.saveContext()
    }
    
    func loadData () {
        do {
            let first_tuple = try context.fetch(PhotoEntity.fetchRequest()).first as! PhotoEntity
            
            for photo in first_tuple.photoObject as! [Photo] {
                myImageView.image = photo.image
                myLabel.text = photo.title
            }
            
            
        } catch {
            print(error)
        }
    }


}

