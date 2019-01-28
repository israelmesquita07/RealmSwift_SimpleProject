//
//  InserViewController.swift
//  learningRealmIO
//
//  Created by Israel Mesquita on 28/01/2019.
//  Copyright © 2019 israel. All rights reserved.
//

import UIKit
import RealmSwift

class InserViewController: UIViewController {

    @IBOutlet weak var txtToDo: UITextField!
    @IBOutlet weak var swToDo: UISwitch!
    
    var incomingToDo: ToDo? = nil
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let goodToDo = incomingToDo {
            txtToDo.text = goodToDo.ToDoText
            swToDo.isOn = goodToDo.isDone
        }
    }
    
    @IBAction func saveToDoItem(_ sender: Any) {
        
        if let goodToDo = incomingToDo {
            try! realm.write {
                goodToDo.ToDoText = txtToDo.text!
                goodToDo.isDone = swToDo.isOn
            }
        } else {
            let todo = ToDo()
            todo.ToDoText = txtToDo.text!
            todo.isDone = swToDo.isOn
            
            try! realm.write {
                realm.add(todo)
            }
        }
       
        navigationController?.popViewController(animated: true)
    }
    
}
