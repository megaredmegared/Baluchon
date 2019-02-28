//
//  ExchangeRateServiceTextField.swift
//  Baluchon
//
//  Created by megared on 28/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//
import Foundation
import UIKit

class ExchangeRateServiceTextField: UITextField {
//    convenience init() {
//        self.init(frame: .zero)
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: frame.size.height)
//
//        border.borderWidth = width
//        layer.addSublayer(border)
//        layer.masksToBounds = true
//    }
}
@IBDesignable
open class customUITextField: UITextField {
    
    func setup() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
