//
//  DatabaseHelper.swift
//  TheToDo
//
//  Created by Jigisha Patel on 2021-03-16.
//

import Foundation
import CoreData
import UIKit

//MVC - Controller
class DatabaseHelper{
    
    //singleton instance
    private static var shared : DatabaseHelper?
    
    static func getInstance() -> DatabaseHelper{
        if shared != nil{
            //instance already exists
            return shared!
        }else{
            // create a new singlton instance
            return DatabaseHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "ToDo"
    
    private init (context : NSManagedObjectContext){
        self.moc = context
    }
    
    //insert
    func insertTask(newTodo: order){
        
        do{
            //try insert new record
            let taskTobeAdded = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! ToDo
            
            taskTobeAdded.name = newTodo.name
            taskTobeAdded.instruction = newTodo.instruction
            taskTobeAdded.id = UUID()
            taskTobeAdded.size = newTodo.size
            taskTobeAdded.noOf = newTodo.noOf
            taskTobeAdded.dateCreated = Date()
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Data inserted successfully")
            }
            
        }catch let error as NSError{
            print(#function, "Could not save the data \(error) ")
        }
        
    }
    
    //search
//    func searchTask(taskTitle : String) -> [ToDo]?{
    func searchTask(taskID : UUID) -> ToDo?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", taskID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            
            let result = try self.moc.fetch(fetchRequest)
            
            if result.count > 0{
                return result.first as? ToDo
            }
            
        }catch let error as NSError{
            print("Unable to search task \(error)")
        }
        
        return nil
    }
    
    //update
    func updateTask(updatedTask: ToDo){
        let searchResult = self.searchTask(taskID: updatedTask.id! as UUID)
        
        if (searchResult != nil){
            do{
                let taskToUpdate = searchResult!
                
                taskToUpdate.name = updatedTask.name
                taskToUpdate.size = updatedTask.size
                taskToUpdate.noOf = updatedTask.noOf
                
                try self.moc.save()
                print(#function, "Task updated successfully")
                
            }catch let error as NSError{
                print(#function, "Unable to search task \(error)")
            }
        }
    }
    
    //delete
    func deleteTask(taskID : UUID)  {
        let searchResult = self.searchTask(taskID: taskID)
        
        if (searchResult != nil){
            //matching record found
            do{
                
                self.moc.delete(searchResult!)
//                try self.moc.save()
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.saveContext()
                
                print(#function, "Task deleted successfully")
                
            }catch let error as NSError{
                print("Unable to delete task \(error)")
            }
        }
    }
    
    //retrieve all todos
    func getAllTodos() -> [ToDo]?{
        let fetchRequest = NSFetchRequest<ToDo>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "dateCreated", ascending: false)]
        
        do{
            
            //execute the request
            let result = try self.moc.fetch(fetchRequest)
            
            print(#function, "Fetched data : \(result as [ToDo])")
            
//            result[0].title
            
            //return the fetched objects after conversion to ToDo objects
            return result as [ToDo]
            
        }catch let error as NSError{
            print("Could not fetch data \(error) \(error.code)")
        }
        
        //no data retrieved
        return nil
    }
}

