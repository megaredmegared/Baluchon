
import UIKit

class TranslateViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet var keyboardToolbar: UIToolbar!
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var translated: UITextView!
    @IBOutlet weak var firstLanguageLabel: UILabel!
    @IBOutlet weak var secondLanguageLabel: UILabel!
    
    // Languages for traduction
    var firstLanguage = "fr"
    var secondLanguage = "en"
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the icon in tab bar to is true color
        setOriginalImage()
        // set first translation
        getTranslation()
    }
    
    //MARK: - Functions
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
    
    /// Button tapped to invert the languages for traduction
    @IBAction func didTapInvertTraductionLanguages() {
        invertTraductionLanguages()
        getTranslation()
    }
    
    
    /// Invert the languages for traduction
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
extension TranslateViewController: UITextViewDelegate {
    /// Attach keyboardToolbar whith done and clear buttons to keyboard
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.inputAccessoryView = keyboardToolbar
        return true
    }
    
    /// Done button when user finished writing
    @IBAction func didTapKeyboardDoneButton(_ sender: UIBarButtonItem) {
        getTranslation()
       textToTranslate.resignFirstResponder()
    }
    
    /// Clear button in keyboard toolbar, to erase the whole text
    @IBAction func didTapKeyboardClearButton(_ sender: UIBarButtonItem) {
        textToTranslate.text = ""
    }
    
    /// Tap away from keyboard to dismiss it
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        getTranslation()
        textToTranslate.resignFirstResponder()
    }
}
