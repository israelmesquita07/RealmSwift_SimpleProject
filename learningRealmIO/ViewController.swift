//
//  ViewController.swift
//  learningRealmIO
//
//  Created by Israel Mesquita on 24/01/2019.
//  Copyright © 2019 israel. All rights reserved.
//

import UIKit
import RealmSwift

var todos:Results<ToDo>!
var realm = try! Realm()

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = realm.objects(ToDo.self)
        tableView.dataSource = self
        tableView.delegate = self
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDo"{
            let destination = segue.destination as! InserViewController
            let todo = todos[tableView.indexPathForSelectedRow!.row]
            destination.incomingToDo = todo
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellToDo", for: indexPath) as! ToDoCell
        
        let todo = todos[indexPath.row]
        cell.lblToDo.text = todo.ToDoText
        cell.lblIsDone.text = todo.isDone ? "Done" : "Do it"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(todos[indexPath.row])
            }
            reload()
        }
    }
    
    func reload(){
        tableView.reloadData()
    }
    
}

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var lblToDo: UILabel!
    @IBOutlet weak var lblIsDone: UILabel!
}


class ToDo:Object{
    @objc dynamic var ToDoText = ""
    @objc dynamic var isDone = false
}
