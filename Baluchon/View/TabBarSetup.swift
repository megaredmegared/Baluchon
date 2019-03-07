
import Foundation
import UIKit

/// Configuration of the tab bar
extension UIViewController {
    /// set the icon in tab bar to is true color when selected
    func setOriginalImage() {
        tabBarItem.selectedImage = tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
    }
}

/// Make the tab bar item above the title in landscape mode so insets behave the same for iphone xsmax and plus and xr
class TabBar: UITabBar {
    override var traitCollection: UITraitCollection {
        if super.traitCollection.horizontalSizeClass == .regular
            && super.traitCollection.verticalSizeClass == .compact  {
            
            return UITraitCollection(horizontalSizeClass: .compact)
        } else  {
            return super.traitCollection
        }
    }
}
