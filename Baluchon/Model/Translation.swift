//
//  Translation.swift
//  Baluchon
//
//  Created by megared on 25/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

struct Translation: Codable {
    
    let data: Translations
    
    struct Translations: Codable {
        
        let translations: [TranslatedText]
        
        struct TranslatedText: Codable {
            
            var translatedText: String
        }
    }
    
}

//{
//    "data": {
//        "translations": [
//        {
//        "translatedText": "Bonjour le monde"
//        }
//        ]
//    }
//}
