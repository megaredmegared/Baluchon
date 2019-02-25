//
//  TabBarSetup.swift
//  Baluchon
//
//  Created by megared on 22/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import UIKit

/// Configuration of the tab bar
extension UIViewController {
    /// set the icon in tab bar to is true color when selected
    func setOriginalImage() {
        tabBarItem.selectedImage = tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
//        tabBarItem.landscapeImagePhone = tabBarItem.landscapeImagePhone?.withRenderingMode(.alwaysOriginal)
    
    }
}
