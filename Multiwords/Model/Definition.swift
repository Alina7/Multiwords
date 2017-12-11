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
    var origJSON:JSON?
    
    required init? (json: JSON) {
        origJSON = json
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
    
    func toString() -> String{
        do{
            let data1 = try JSONSerialization.data(withJSONObject: origJSON!, options: JSONSerialization.WritingOptions.prettyPrinted)
            let newStr = String(data: data1, encoding: String.Encoding.utf8)
            return (newStr)!
        }catch (let error){
            print("Def toString error: \(error.localizedDescription)")
        }
        return ""
    }
    
}
