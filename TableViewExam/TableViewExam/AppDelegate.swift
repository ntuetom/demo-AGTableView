//
//  AppDelegate.swift
//  TableViewExam
//
//  Created by Wu hung-yi on 2020/9/3.
//  Copyright © 2020 Wu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initView()
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func initView() {
        if window == nil {
            window = UIWindow.init(frame: UIScreen.main.bounds)
            window?.backgroundColor = .white
            window?.rootViewController = UINavigationController(rootViewController: ExamViewController(row: 1, column: 1))
            window?.makeKeyAndVisible()
        }
    }

}

