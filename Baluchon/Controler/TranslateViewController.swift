//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by megared on 18/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var translated: UITextView!
    @IBOutlet weak var firstLanguageLabel: UILabel!
    @IBOutlet weak var secondLanguageLabel: UILabel!
    
    var firstLanguage = "fr"
    var secondLanguage = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the icon in tab bar to is true color
        setOriginalImage()
        getTranslation()
    }
    
    /// Get translation from a text
    private func getTranslation() {
        TranslateService.shared.getTranslation(for: textToTranslate.text, from: firstLanguage, to: secondLanguage) { (success, translation) in
            if success, let translation = translation {
                self.translated.text = translation.data.translations[0].translatedText
            } else {
                self.presentAlert()
            }
        }
    }
    
    @IBAction func didTapInvertTraductionLanguages() {
        invertTraductionLanguages()
        getTranslation()
    }
    

    private func invertTraductionLanguages() {
        if firstLanguage == "fr" {
            firstLanguage = "en"
            firstLanguageLabel.text = "anglais"
            secondLanguage = "fr"
            secondLanguageLabel.text = "français"
        } else {
            firstLanguage = "fr"
            firstLanguageLabel.text = "français"
            secondLanguage = "en"
            secondLanguageLabel.text = "anglais"
        }
        textToTranslate.text = translated.text
    }
    
    
    
    
    
    /// Alert pop up message
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The translation has failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}

// MARK: - Keyboard
extension TranslateViewController: UITextViewDelegate{
    
    /// Clear the value in textView to begin tapping a new one
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == textToTranslate {
            textToTranslate.text = ""
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        getTranslation()
        textToTranslate.resignFirstResponder()
    }
    


}
