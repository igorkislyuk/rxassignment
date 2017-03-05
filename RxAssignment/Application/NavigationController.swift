//
// Created by Igor on 05/03/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    var onViewDidLoad: ( (NavigationController)->() )?

    override func viewDidLoad() {
        super.viewDidLoad()

        onViewDidLoad?(self)
    }

}
