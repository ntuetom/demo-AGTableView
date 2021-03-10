//
//  ExamCollectionViewCell.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/3.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit

enum RowDataType {
    case randomCell, buttnCell
}

class ExamCollectionViewCell: UICollectionViewCell {
    
    var viewModel: ExamViewModel?
    let footerHeight: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                layer.borderColor = UIColor.cyan.cgColor
                layer.borderWidth = 2.5
                layer.cornerRadius = 5
            } else {
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ExamTableViewCell.self, forCellReuseIdentifier: "ExamTableViewCell")
        tv.register(ExamButtonCell.self, forCellReuseIdentifier: "ExamButtonCell")
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.bounces = false
        return tv
    }()
    
    func setupSubView() {
        addSubview(tableView)
    }
    
    func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setup(vm: ExamViewModel, selected: Bool) {
        isSelected = selected
        viewModel = vm
        tableView.reloadData()
    }

}

extension ExamCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let vm = viewModel else {
            return CGFloat.leastNonzeroMagnitude
        }
        switch vm.rowData[indexPath.row] {
        case .randomCell:
            return (frame.size.height - footerHeight) / CGFloat(vm.inputRow)
        case .buttnCell:
            return footerHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else {
            return 0
        }
        return vm.rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel else {
            return UITableViewCell()
        }
        switch vm.rowData[indexPath.row] {
        case .randomCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ExamTableViewCell") as? ExamTableViewCell {
                cell.toggleText(isToggle: Int(vm.selectedIndex.x) == indexPath.row && isSelected)
                return cell
            }
        case .buttnCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ExamButtonCell") as? ExamButtonCell {
                cell.setup(delegate: self, toggle: isSelected)
                return cell
            }
        }
        return UITableViewCell()
    }
    
}

extension ExamCollectionViewCell: ExamButtonCellDelegate{
    func onButttonClick() {
        guard let vm = viewModel else {return}
        isSelected = false
        vm.resetIndex()
        tableView.reloadData()
    }
}
