//
//  InitialView.swift
//  RxAssignment
//
//  Created by Igor on 05/03/2017.
//  Copyright © 2017 Igor Kislyuk. All rights reserved.
//

import Foundation

protocol InitialView: Presentable {

    var openDetail: ( (Int) -> () )? { get set }

}
