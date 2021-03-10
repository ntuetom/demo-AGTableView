//
//  InputView.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/5.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit

class InputView: PopupContentView {
    
    let viewModel = InputViewModel()
    
    override init(frame: CGRect) {
//        super.init(frame: CGRect(origin: .zero, size: CGSize(width: kScreenW/3*2, height: kScreenH/2)))
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var rowLabel: UILabel = {
        let lb = UILabel()
        lb.text = "列數:"
        return lb
    }()
    
    lazy var columnLabel: UILabel = {
        let lb = UILabel()
        lb.text = "欄數:"
        return lb
    }()
    
    lazy var rowTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "請輸入大於0的整數"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    lazy var columnTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "請輸入大於0的整數"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    lazy var hintLabel: UILabel = {
        let lb = UILabel()
        lb.isHidden = true
        lb.textColor = .red
        return lb
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("確定", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onClick), for: .touchDown)
        return btn
    }()
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
    }
    
    func setupSubView() {
        addSubview(rowLabel)
        addSubview(columnLabel)
        addSubview(rowTextField)
        addSubview(columnTextField)
        addSubview(hintLabel)
        addSubview(button)
    }

    func setupConstraint() {
        rowLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(50)
        }
        columnLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(rowLabel.snp.bottom).offset(20)
        }
        rowTextField.snp.makeConstraints { make in
            make.centerY.equalTo(rowLabel)
            make.left.equalTo(rowLabel.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        columnTextField.snp.makeConstraints { make in
            make.centerY.equalTo(columnLabel)
            make.left.equalTo(rowTextField)
            make.right.equalToSuperview().offset(-10)
        }
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(columnTextField.snp.bottom).offset(20)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hintLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    @objc func onClick() {
        guard let row = rowTextField.text, let column = columnTextField.text else {
            return
        }
        viewModel.setData(row: row, column: column)
        let checkData = viewModel.checkValue()
        if checkData.isValid {
            deleage.onClose(data: (row: viewModel.row, column: viewModel.column))
            endEditing(true)
        } else {
            hintLabel.isHidden = false
            hintLabel.text = checkData.err
        }
    }
}
