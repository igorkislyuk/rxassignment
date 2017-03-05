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

        var initial = initialView()
        initial.openDetail = {
            [weak self]
            item in

            if let detail = self?.detailView() {
                detail.setupWith(detailID: item)
                self?.push(detail)
            }
        }
        push(initial)
    }

    private func push(_ element: Presentable) {
        if navigationController.viewControllers.isEmpty {
            navigationController.viewControllers = [element.toPresent()]
        } else {
            navigationController.pushViewController(element.toPresent(), animated: true)
        }
    }

    private func pop() {
        navigationController.popViewController(animated: true)
    }


    // This could be moved to factory
    private func initialView() -> InitialView {
        return InitialViewController.controllerInStoryboard(UIStoryboard(name: "Main", bundle: nil))
    }

    private func detailView() -> DetailView {
        return DetailViewController.controllerInStoryboard(UIStoryboard(name: "Main", bundle: nil))
    }


}
