//
//  ViewController.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/3.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {

    let viewModel: ExamViewModel
    var examView: ExamView!
    
    weak var collectionView: UICollectionView!
    weak var timer: Timer?
    weak var observer: NSObjectProtocol?
    
    init(row: Int, column: Int) {
        viewModel = ExamViewModel(row: row, column: column)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.invalidate()
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    override func loadView() {
        examView = ExamView(vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.getRandomValue()
        timer = Timer.scheduledTimer(withTimeInterval: viewModel.updateTimeInterval, repeats: true) { [weak self] _ in
            self?.viewModel.getRandomValue()
            self?.collectionView.reloadData()
        }
        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] notification in
            self?.presentPopup()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            examView.didRoate()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentPopup()
    }

    func presentPopup() {
        let vc = PopupViewController(contentView: InputView()) { [weak self] data in
            guard let `self` = self, let index = data as? (row: Int, column: Int) else {
                return
            }
            self.viewModel.setupInput(row: index.row, column: index.column)
            self.collectionView.reloadData()
        }
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }

}

extension ExamViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width-CGFloat(viewModel.inputColumm-1)*viewModel.collectionCellMinimumLineSpacing) / CGFloat(viewModel.inputColumm), height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.inputColumm
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExamCollectionViewCell", for: indexPath) as? ExamCollectionViewCell {
            
            cell.setup(vm: viewModel, selected: indexPath.row == Int(viewModel.selectedIndex.y))
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

