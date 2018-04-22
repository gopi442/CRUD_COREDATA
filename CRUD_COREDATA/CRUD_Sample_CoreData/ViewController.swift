//
//  ViewController.swift
//  CRUD_Sample_CoreData
//
//  Created by Gopal Gupta on 19/04/18.
//  Copyright © 2018 Gopal Gupta. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    
    @IBOutlet weak var txtUName: UITextField!
    @IBOutlet weak var txtUAge: UITextField!
    @IBOutlet weak var txtUPosition: UITextField!
    
    @IBOutlet weak var txtCarName: UITextField!
    @IBOutlet weak var txtCarModel: UITextField!
    @IBOutlet weak var txtCarColor: UITextField!
    
    @IBOutlet weak var tblPreview: UITableView!
    
    var appDelegate : AppDelegate!
    var context : NSManagedObjectContext!
    var newUser : NSManagedObject!
    var newCars : NSManagedObject!
    var request : NSFetchRequest<NSFetchRequestResult>!
    var result  : NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        let entityUser = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let entityCars = NSEntityDescription.entity(forEntityName: "Cars", in:  context)
        newUser = NSManagedObject(entity: entityUser!, insertInto: context)
        newCars = NSManagedObject(entity: entityCars!, insertInto: context)
        
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            print("ViewController touch Began")
            next?.touchesBegan(touches, with: event)
        }

        
    }

    @IBAction func btnAdd(_ sender: Any) {
        if (txtUName.text != "" ){
            newUser.setValue(txtUName.text, forKey: "name")
            newUser.setValue(txtUAge.text, forKey: "age")
            newUser.setValue(txtUPosition.text, forKey: "position")
            funToSaveInDB()
            txtUName.text=""
            txtUAge.text=""
            txtUPosition.text=""
            
        }else{
            print("please enter user name ")
        }
        
    }
    
    @IBAction func btnAddCars(_ sender: Any) {
    if (txtCarName.text != "" ){
        newCars.setValue(txtCarName.text, forKey: "name")
        newCars.setValue(txtCarModel.text, forKey: "modelnum")
        newCars.setValue(txtCarColor.text, forKey: "color")
        funToSaveInDB()
        txtCarName.text=""
        txtCarModel.text=""
        txtCarColor.text=""
        
    }else{
          print("please enter  car name ")
        }
    }
    
    func funToSaveInDB(){
        do {
            try context.save()
            } catch {
                print("Failed saving")
            }
        
    }
    @IBAction func btnViewUsers(_ sender: Any) {
        request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            result = try context.fetch(request) as NSArray
            if result.count>0 {
                tblPreview.delegate=self
                tblPreview.dataSource=self
                tblPreview.reloadData()
            }
            
        } catch {
            print("Failed")
        }
    }
    
    @IBAction func btnViewCars(_ sender: Any) {
        request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cars")
        request.returnsObjectsAsFaults = false
        do {
            result = try context.fetch(request) as NSArray
            if result.count>0 {
                tblPreview.delegate=self
                tblPreview.dataSource=self
                 tblPreview.reloadData()
            }
            
        } catch {
            print("Failed")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // return
        let cell : UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "cell11")
        
        let data = result as! NSManagedObject
        let str1 = data.value(forKey: "username") as! String
        cell?.textLabel?.text = str1
        return cell!
    }

}
extension UIWindow{
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Window Touch Began")
        next?.touchesBegan(touches, with: event)
    }
}
extension UIView{
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("UIView touch Began")
        next?.touchesBegan(touches, with: event)
    }
}
