//
//  AppDelegate.swift
//  RxAssignment
//
//  Created by Igor on 05/03/2017.
//  Copyright © 2017 Igor Kislyuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var applicationCoordinator: Coordinator = {
        return ApplicationCoordinator(navigationController: self.window!.rootViewController as! NavigationController)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        applicationCoordinator.start()
        return true
    }


}

