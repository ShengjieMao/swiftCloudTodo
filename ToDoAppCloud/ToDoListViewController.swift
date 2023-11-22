//
//  ToDoListViewController.swift
//  ToDoAppCloud
//
//  Created by Shengjie Mao on 11/21/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    let arr = ["1", "2"]
    var txtField: UITextField?
    var db: Firestore!
    var uid: String = ""
    
    var todos: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // the user id in firestore database
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.uid = uid

        // START setup
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        // END setup
        db = Firestore.firestore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllTodos()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row]
        return cell
    }

    
    @IBAction func addTodo(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { action in
            guard let todo = self.txtField?.text else {return}
            self.addToDB(todo: todo)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("Cancel Button Pressed")
        }
        
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        alertController.addTextField { txtField in
            txtField.placeholder = "Type something here"
            self.txtField = txtField
        }
        
        self.present(alertController, animated: true)
    }
    
    func addToDB(todo : String) {
        print(todo)
        let newToDo = db.collection(uid).document()
        newToDo.setData([
            "todo": todo
        ])
        getAllTodos()
    }
    
    func getAllTodos(){
        todos = [String]()
        db.collection(uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            for document in querySnapshot!.documents {
                print("\(document.documentID) => \(document.data())")
                guard let todo = document.data()["todo"] as? String else {continue}
                self.todos.append(todo)
            }
            self.tblView.reloadData()
        }
    }
}
