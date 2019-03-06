
import Foundation

/// translated text
struct Translation: Codable {
    
    let data: Translations
    
    struct Translations: Codable {
        
        let translations: [TranslatedText]
        
        struct TranslatedText: Codable {
            
            var translatedText: String
        }
    }
    
}
