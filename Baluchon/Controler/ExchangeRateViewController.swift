//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by megared on 20/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet var keyboardToolbar: UIToolbar!
    
    @IBOutlet weak var firstExchangeRate: UILabel!
    @IBOutlet weak var secondExchangeRate: UILabel!
    
    @IBOutlet weak var firstValue: UITextField!
    @IBOutlet weak var secondValue: UITextField!
    
    @IBOutlet weak var firstMoneyPicker: UIPickerView!
    @IBOutlet weak var secondMoneyPicker: UIPickerView!
    
    /// Temporarly saved the data rates will app is running
    var exchangeRateTemporarlySaved = ExchangeRate()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the icon in tab bar to is true color
        setOriginalImage()
        // set first picker to Euro
        firstMoneyPicker.selectRow(0, inComponent:0, animated:true)
        // set second picker to Dollar
        secondMoneyPicker.selectRow(1, inComponent:0, animated:true)
        // Get exchange rates at start
        getRates()
    }
    
    //MARK: - Functions
    /// Get exchange rate and store it until the app is closed
    private func getRates() {
        ExchangeRateService.shared.getExchangeRate { (success, exchangeRate) in
            if success, let exchangeRate = exchangeRate {
                self.exchangeRateTemporarlySaved = exchangeRate
            } else {
                self.presentAlert()
            }
        }
    }
    
    /// Update the exchange rates on screen
    private func updateView(exchangeRate: ExchangeRate) {
        // Find the selected index of the currencie in pickers
        let firstCurrency: Int = firstMoneyPicker.selectedRow(inComponent: 0)
        let secondCurrency: Int = secondMoneyPicker.selectedRow(inComponent: 0)
        
        // Translate currencie in the symbol form
        let firstCurrencySymbol: String = Currency.symbol[Currency.name[firstCurrency]]!
        let secondCurrencySymbol: String = Currency.symbol[Currency.name[secondCurrency]]!
        
        // Set the labels with the currencie exchange rates
        firstExchangeRate.text = "1 \(firstCurrencySymbol)"
        let secondCurrencyExchangeRate: Double = round(exchangeRate.rates[secondCurrencySymbol]! / exchangeRate.rates[firstCurrencySymbol]! * 100) / 100
        secondExchangeRate.text = "\(secondCurrencyExchangeRate) \(secondCurrencySymbol)"
        
        // Set the values in big number label
        if firstValue.text == "" {
            firstValue.text = "1.0"
        }
        secondValue.text = String(round(Double(firstValue.text!)! * secondCurrencyExchangeRate*100)/100)
    }
    
    /// Alert pop up message
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Today sync of exchange rate failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Money Pickers Delegate
extension ExchangeRateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == firstMoneyPicker {
            return Currency.name.count
        } else {
            return Currency.name.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstMoneyPicker {
            return Currency.name[row]
        } else {
            return Currency.name[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateView(exchangeRate: exchangeRateTemporarlySaved)
    }
    
}

// MARK: - Keyboard
extension ExchangeRateViewController: UITextFieldDelegate {
    /// Attach keyboardToolbar to the keyboard
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.inputAccessoryView = keyboardToolbar
        return true
    }
    /// Tap Done button from keyboardToolbar to dismiss the keyboard
    @IBAction func didTapKeyboardDoneButton(_ sender: UIBarButtonItem) {
        updateView(exchangeRate: exchangeRateTemporarlySaved)
        view.endEditing(true)
    }
    /// Clear the value in text field to begin tapping a new one
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == firstValue {
            firstValue.text = ""
        }
    }
    /// Tap away from keyboard to dismiss it
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        updateView(exchangeRate: exchangeRateTemporarlySaved)
        view.endEditing(true)
        //TODO: - Ask what is better solution ?
        //firstValue.resignFirstResponder() -> better ?
    }
}
