
import Foundation
import UIKit

/// Text padding for UITextField
class UITextFieldPadding : UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

/// Text padding for UILabel
class UILabelPadding : UILabel {
    static var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UILabelPadding.padding))
    }
}

/// Text padding for UITextView
class PaddingUITextView: UITextView {
    //TODO: - Override of stored property not possible?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
    }
}


