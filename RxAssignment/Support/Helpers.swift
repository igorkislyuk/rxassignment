//
// Created by Igor on 05/03/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    private class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }

    class func controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
        return instantiateControllerInStoryboard(storyboard, identifier: nameOfClass)
    }
}

extension NSObject {

    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
