//
//  InputViewModel.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/5.
//  Copyright © 2020 Wu. All rights reserved.
//

import Foundation

class InputViewModel {
    
    var row: Int = -1
    var column: Int = -1
    
    func setData(row: String, column: String) {
        if let _row = Int(row){
            self.row = _row
        }
        if let _column = Int(column){
            self.column = _column
        }
    }
    
    func checkValue() -> (isValid: Bool, err: String?) {
        if row > 0 && column > 0 {
            return (true, nil)
        } else {
            return (false, "請輸入大於0的整數")
        }
    }
}
