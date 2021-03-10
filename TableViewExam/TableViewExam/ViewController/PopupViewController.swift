//
//  Popup.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/5.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit

protocol PopupDelegate: NSObjectProtocol {
    func onClose(data: Any)
}

class PopupContentView: UIView {
    weak var deleage: PopupDelegate!
}

class PopupViewController: UIViewController, PopupDelegate {

    weak var contentView: UIView!
    var completion: ((Any) -> Void)?
    
    init(contentView: PopupContentView, completion: ((Any) -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        self.contentView = contentView
        self.completion = completion
        view.addSubview(contentView)
        setupConstraint()
        contentView.deleage = self
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onTap))
        view.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)
         setupConstraint()
    }
    
    func setupConstraint() {
        contentView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func onClose(data passData: Any) {
        completion?(passData)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onTap() {
        view.endEditing(true)
    }

}
