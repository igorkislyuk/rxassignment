//
// Created by Igor on 05/03/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

import UIKit

class ItemCoordinator: BaseCoordinator {

    let navigationController: NavigationController

    init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    override func start() {

        let initial = InitialViewController.controllerInStoryboard(UIStoryboard(name: "Main", bundle: nil))
        
        if navigationController.viewControllers.isEmpty {
            navigationController.viewControllers = [initial]
        } else {
            navigationController.pushViewController(initial, animated: false)
        }

    }


}
