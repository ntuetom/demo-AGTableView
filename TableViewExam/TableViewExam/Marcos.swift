//
//  Marcos.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/3.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit
@_exported import SnapKit

let kScreenH: CGFloat = UIScreen.main.bounds.size.height
let kScreenW: CGFloat = UIScreen.main.bounds.size.width

let kNavigationbarHeight:  CGFloat = 44.0
let kSafeAreaStatusHeight: CGFloat = kScreenH >= 812.0 ? 44.0: 20.0
let kSafeAreaBottomHeight: CGFloat = kScreenH >= 812.0 ? 34.0 : 0.0
let kSafeAreaTopHeight:    CGFloat = kSafeAreaStatusHeight + kNavigationbarHeight

var appDelegate: AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
}
