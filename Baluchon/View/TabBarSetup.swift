
import Foundation
import UIKit

/// Configuration of the tab bar
extension UIViewController {
    /// set the icon in tab bar to is true color when selected
    func setOriginalImage() {
        tabBarItem.selectedImage = tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
    }
}
