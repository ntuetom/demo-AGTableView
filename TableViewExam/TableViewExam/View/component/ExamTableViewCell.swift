//
//  ExamTableViewCell.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/3.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit

class ExamTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.5)
        selectionStyle = .none
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var randomLabel: UILabel = {
        let lb = UILabel()
        lb.text = "random"
        lb.textColor = .black
        lb.isHidden = true
        return lb
    }()
    
    lazy var bottomLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    func setupSubView() {
        contentView.addSubview(seperatorView)
        contentView.addSubview(randomLabel)
        contentView.addSubview(bottomLineView)
    }
    
    func setupConstraint() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            make.right.equalToSuperview().offset(-2)
        }
        seperatorView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(10)
            make.top.left.right.equalToSuperview()
        }
        randomLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        bottomLineView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(8)
            make.bottom.left.right.equalToSuperview()
        }
    }

    func toggleText(isToggle: Bool) {
        randomLabel.isHidden = !isToggle
    }
}
