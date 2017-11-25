//
//  ArticleElement.swift
//  Multiwords
//
//  Created by Алина Князева on 26.11.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import Gloss

class ArticleElement: Gloss.JSONDecodable {
    
    let text: String
    let number: String?
    let partOfSpeech: String?
    let gender: String?
    
    required init?(json: JSON) {
        
        guard let text: String = "text" <~~ json else {
            return nil
        }
        
        self.text = text
        self.number = "num" <~~ json
        self.partOfSpeech = "pos" <~~ json
        self.gender = "gen" <~~ json
    }
    
}

