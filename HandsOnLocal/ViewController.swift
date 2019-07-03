//
//  ViewController.swift
//  HandsOnLocal
//
//  Created by Josiah Elisha on 03/07/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults fetch
//        let text = UserDefaults.standard.string(forKey: "Name")
//        myLabel.text = text
        ///////
        
        //Core Data Fetch
        myLabel.text = ""
        //////paling penting//////////
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return  }
        //////////////////////////////////
        
        //bikin temporary container buat nampung fetched object
        var users = [User]()
        

        
        do {
            //di fetch berbentuk array of any
            users = try managedContext.fetch(User.fetchRequest())
            //looping array untuk dapatkan objek entity
            for user in users {
                //ambil value dari key yang ada di objek entity
                let name = user.value(forKey: "name") as! String
                //tampilkan (label/konsol)
                myLabel.text! += " \(name)"
                print(name)
            }
            //Delete
            //            for user in users {
            //                let deletedUser = user as! NSManagedObject
            //                managedContext.delete(deletedUser)
            //            }
            //            do {
            //                try managedContext.save()
            //            } catch  {
            //                debugPrint("aaaaaa")
            //            }
        } catch {
            print("No text is received")
        }
        
    }


    @IBAction func save(_ sender: UIButton) {
        //Core Data Save
        //////paling penting//////
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        //////////////////////////////
        
        //bikin entity
        let user = User(context: managedContext)
        //tinggal masukin ke keyvalue (disini keynya "name")
        user.name = myTextField.text
        
        do {
            //tinggal save contextnya
            try managedContext.save()
            print("saved user")
        } catch  {
            print("no managed context")
        }
        
        //UserDefaults Save
//        myLabel.text = myTextField.text
//        UserDefaults.standard.set(myLabel.text, forKey: "Name")
    }
}

