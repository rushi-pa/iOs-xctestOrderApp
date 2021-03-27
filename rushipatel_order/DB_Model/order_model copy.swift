//
//  order_model.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-02-17.
//

import Foundation

class order{
    var name : String
    var size : String
    var noOf : String
    var instruction : String
    
    init() {
       
        self.name = ""
        self.size = ""
        self.noOf = ""
        self.instruction = ""
    }
    
    init(name : String, size: String, noOf: String, instruction: String) {
        
        self.name = name
        self.size = size
        self.noOf = noOf
        self.instruction = instruction
    }

}
extension order{
    public class func getInitialData() -> [order]{
        return [
            //order(name: "Table View", size: "Add Rows" , noOf: "19", instruction: "")
        ]
    }
}
