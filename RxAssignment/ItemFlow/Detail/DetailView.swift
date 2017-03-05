//
// Created by Igor on 05/03/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

import Foundation

protocol DetailView: Presentable {
    func setupWith(detailID id: Int)
}
