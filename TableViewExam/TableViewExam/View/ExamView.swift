//
//  ExamView.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/3.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit

class ExamView: UIView {
    
    let viewModel: ExamViewModel
    var owner: AnyObject?
    
    init(vm: ExamViewModel, owner: AnyObject?, frame: CGRect? = nil) {
        viewModel = vm
        super.init(frame: UIScreen.main.bounds)
        self.owner = owner
        setupSubView()
        setupConstraint()
        setupRefernce()
        setupRefernceOutlets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionViewlayout: UICollectionViewFlowLayout {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        cvLayout.minimumLineSpacing = viewModel.collectionCellMinimumLineSpacing
        return cvLayout
    }
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        cv.backgroundColor = .clear
        cv.register(ExamCollectionViewCell.self, forCellWithReuseIdentifier: "ExamCollectionViewCell")
        cv.backgroundColor = .white
        return cv
    }()
    
    func didRoate() {
        collectionView.collectionViewLayout = collectionViewlayout
        collectionView.reloadData()
    }
    
    func setupSubView() {
        addSubview(collectionView)
    }
    
    func setupConstraint(){
        collectionView.snp.remakeConstraints { make in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(safeAreaLayoutGuide)
            } else {
                make.edges.top.equalTo(layoutMarginsGuide)
            }
        }
    }
    
    func setupRefernce() {
        if owner != nil && owner!.isKind(of: UIViewController.classForCoder()){
            (owner as! UIViewController).view = self
        }
        if let vc = owner as? ExamViewController {
            vc.collectionView = collectionView
        }
    }
    
    func setupRefernceOutlets() {
        if let vc = owner as? ExamViewController {
            collectionView.delegate = vc
            collectionView.dataSource = vc
        }
    }
}
