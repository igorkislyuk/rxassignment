//
// Created by Igor on 05/03/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: BaseCoordinator {

    let navigationController: NavigationController

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        navigationController.onViewDidLoad = {
            navigationController in
            if navigationController.viewControllers.isEmpty {

                let itemCoordinator = ItemCoordinator(navigationController)

                itemCoordinator.start()


            }
        }
    }


}
