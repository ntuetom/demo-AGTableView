//
//  ExamFooterView.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/3.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit

protocol ExamButtonCellDelegate: AnyObject {
    func onButttonClick()
}

class ExamButtonCell: UITableViewCell {
    
    weak var delegate: ExamButtonCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .darkGray
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
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var label: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.highlightedTextColor = .white
        lb.text = "確定"
        return lb
    }()
    
    func setupSubView() {
        addSubview(seperatorView)
        addSubview(button)
        addSubview(label)
    }
    
    func setupConstraint() {
        seperatorView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(10)
            make.top.left.right.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalTo(button)
            make.bottom.equalTo(button).offset(-5)
        }
    }
    
    func setup(delegate: ExamButtonCellDelegate, toggle: Bool) {
        self.delegate = delegate
        toggleButton(toggel: toggle)
    }
    
    func toggleButton(toggel: Bool) {
        button.backgroundColor = toggel ? .cyan : .clear
        label.isHighlighted = toggel
    }
    
    @objc func onClick() {
        toggleButton(toggel: false)
        delegate?.onButttonClick()
    }
}
