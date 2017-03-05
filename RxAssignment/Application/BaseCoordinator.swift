//
// Created by Igor on 05/03/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

import Foundation

class BaseCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    func start() {
        assertionFailure("must be overridden")
    }

    // add only unique object
    func addDependency(_ coordinator: Coordinator) {

        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard
                childCoordinators.isEmpty == false,
                let coordinator = coordinator
                else { return }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

