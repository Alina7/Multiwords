//
//  Translation.swift
//  Multiwords
//
//  Created by Алина Князева on 26.11.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import Gloss


class Translation: Gloss.JSONDecodable {
    
    let text: String
    let partOfSpeech: String?
    let gender: String?
    let synonims: [ArticleElement]
    let meanings: [ArticleElement]
    let examples: [ArticleElement]
    
    required init?(json: JSON) {
        
        guard let text: String = "text" <~~ json else {
            return nil
        }
        
        self.partOfSpeech = "pos" <~~ json
        self.gender = "gen" <~~ json
        
        self.synonims = "syn" <~~ json ?? []
        self.meanings = "mean" <~~ json ?? []
        self.examples = "ex" <~~ json ?? []
        self.text = text
    }
}
