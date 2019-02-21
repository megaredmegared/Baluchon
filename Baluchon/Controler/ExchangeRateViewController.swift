//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by megared on 20/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {

    @IBOutlet weak var firstMoneyPicker: UIPickerView!
    @IBOutlet weak var secondMoneyPicker: UIPickerView!
    var firstPickerData = ["EURO", "DOLLARS", "DOLLARS AUSTRALIEN", "MNM"]
    var secondPickerData = ["EUR", "DOL", "LIR"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the icon in tab bar to is true color
tabBarItem.selectedImage = tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
        // Do any additional setup after loading the view.
    }

}

// MARK: - Money Pickers Delegate
extension ExchangeRateViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == firstMoneyPicker {
         return firstPickerData.count
        } else {
            return secondPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstMoneyPicker {
            return firstPickerData[row]
        } else {
            return secondPickerData[row]
        }
    }
}
