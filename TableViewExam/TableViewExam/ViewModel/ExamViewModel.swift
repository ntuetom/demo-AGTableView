//
//  ExamViewModel.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/3.
//  Copyright © 2020 Wu. All rights reserved.
//

import Foundation

class ExamViewModel {
    
    let collectionCellMinimumLineSpacing: CGFloat = 0
    var inputColumm: Int = 3
    var inputRow: Int = 4
    var updateTimeInterval: TimeInterval = 10
    var selectedIndex: CGPoint = .zero
    var rowData: [RowDataType] = []
    
    init(row: Int, column: Int) {
        self.inputRow = row
        self.inputColumm = column
        setupInput(row: inputRow, column: inputColumm)
        resetIndex()
    }
    
    func setupInput(row: Int, column: Int) {
        inputRow = row
        inputColumm = column
        
        rowData.removeAll()
        for i in 0...row {
            if i == row {
                rowData.append(RowDataType.buttnCell)
            } else {
                rowData.append(RowDataType.randomCell)
            }
        }
    }
    
    func resetIndex() {
        selectedIndex = CGPoint(x: -1, y: -1)
    }
    
    func getRandomValue() {
        let randomX = Int.random(in: 0...inputRow-1)
        let randomY = Int.random(in: 0...inputColumm-1)
        selectedIndex = CGPoint(x: randomX, y: randomY)
    }
    
    var row: Int {
        return inputRow + 1
    }
}
