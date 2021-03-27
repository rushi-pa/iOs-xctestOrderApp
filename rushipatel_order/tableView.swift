//
//  tableView.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-02-17.
//

import UIKit

class tableView: UITableViewController {
    
    private var taskList : [ToDo] = [ToDo]()
    
    private let dbHelper = DatabaseHelper.getInstance();
    
    override func viewDidLoad() {
        super.viewDidLoad()
            if (self.dbHelper.getAllTodos() != nil){
                self.taskList = self.dbHelper.getAllTodos()!
                print(taskList);
            }else{
                print(#function, "No data recieved from dbHelper")
            }
        self.setUpLongPressGesture()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(taskList.count);
        return self.taskList.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableViewcell
        if indexPath.row < taskList.count{
        let task = taskList[indexPath.row]
            print(task);
        cell.t1.text = task.name;
        cell.t2.text = task.size;
        cell.t3.text = task.noOf;
        }
        return cell
        }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            let task = taskList[indexPath.row];
            dbHelper.deleteTask(taskID: task.id!);
            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            fetchAllToDos()
        }
    }
    private func fetchAllToDos(){
         if (self.dbHelper.getAllTodos() != nil){
             self.taskList = self.dbHelper.getAllTodos()!
             self.tableView.reloadData()
         }else{
             print(#function, "No data recieved from dbHelper")
         }
     }
    private func setUpLongPressGesture(){
           let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
           
           longPressGesture.minimumPressDuration = 1.0 //1 second
           
           self.tableView.addGestureRecognizer(longPressGesture)
       }
       
       @objc
       private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
           if gestureRecognizer.state == .ended{
               let touchPoint = gestureRecognizer.location(in: self.tableView)
               
               if let indexPath = self.tableView.indexPathForRow(at: touchPoint){
                   
                   self.displayCustomAlert(isNewTask: false, indexPath: indexPath, title: "Edit Task", message: "Please provide the updated details")
               }
           }
       }
    
      private func displayCustomAlert(isNewTask : Bool, indexPath: IndexPath?, title: String, message: String){
          
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          
          if (isNewTask){
              alert.addTextField{(textField: UITextField) in
                  textField.placeholder = "What do you want to do?"
              }
              alert.addTextField{(textField: UITextField) in
                  textField.placeholder = "Provide the details"
                  textField.keyboardType = .default
                  textField.autocorrectionType = .yes
              }
          }else if (indexPath != nil){
              alert.addTextField{(textField: UITextField) in
                  textField.text = self.taskList[indexPath!.row].name
              }
              
              alert.addTextField{(textField: UITextField) in
                  textField.text = self.taskList[indexPath!.row].noOf
              }
          }
          
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
              if let titleText = alert.textFields?[0].text, let subtitleText = alert.textFields?[1].text{
                  
                  if (isNewTask){
                  //    self.addTaskToList(title: titleText, subtitle: subtitleText)
                  }else if (indexPath != nil){
                      self.updateTaskInList(indexPath: indexPath!, name: titleText, noOf: subtitleText)
                  }
              }
          }))
          
          self.present(alert, animated: true, completion: nil)
          
      }
    private func updateTaskInList(indexPath: IndexPath, name: String, noOf: String){
        self.taskList[indexPath.row].name = name
        self.taskList[indexPath.row].noOf = noOf
        self.dbHelper.updateTask(updatedTask: self.taskList[indexPath.row])
        self.fetchAllToDos()
    }
}
