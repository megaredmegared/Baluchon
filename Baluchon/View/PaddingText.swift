
import UIKit

/// Text padding for UITextField
class UITextFieldPadding : UITextField {
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        padding()
//    }
//
//    let insets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
//
//    func padding() {
//        let bound = bounds.inset(by: insets)
//        textRect(forBounds: bound )
//        placeholderRect(forBounds: bound)
//        editingRect(forBounds: bound)
//    }
    
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
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
}

/// Text padding for UITextView
class PaddingUITextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        padding()
    }
    
    func padding() {
        contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


