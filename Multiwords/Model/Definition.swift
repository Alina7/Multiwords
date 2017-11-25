//
//  Definition.swift
//  Multiwords
//
//  Created by Алина Князева on 26.11.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import Gloss

class Definition: Gloss.JSONDecodable {
    
    let text: String
    let partOfSpeech: String?
    let transcription: String?
    let translations: [Translation]
    
    required init? (json: JSON) {
        
        guard let translations: [Translation] = "tr" <~~ json else {
            return nil
        }
        
        guard let text: String = "text" <~~ json else {
            return nil
        }
        
        self.text = text
        self.translations = translations
        self.partOfSpeech = "pos" <~~ json
        self.transcription = "ts" <~~ json
        
        
    }
    
}
