//
//  DataGloss.swift
//  Multiwords
//
//  Created by Алина Князева on 26.11.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import Gloss

struct defArray: JSONDecodable {
    let textDef: String?
    let posDef: String?
    let tsDef: String?
    
        init? (json: JSON) {
        
        self.textDef = "text" <~~ json
        self.posDef = "pos" <~~ json
        self.tsDef = "ts" <~~ json
        
    }
}

struct ArrayTr: JSONDecodable {
    let textTr: String?
    let posTr: String?
    let gen: String?
    
    init? (json: JSON){
        self.textTr = "text" <~~ json
        self.posTr = "pos" <~~ json
        self.gen = "gen" <~~ json
    }
}

struct meanArray: JSONDecodable {
    let textMean: String?
    
    init? (json: JSON){
        self.textMean = "text" <~~ json
    }
}

struct exArray: JSONDecodable {
    let textEx: String?
    
    init? (json: JSON){
        self.textEx = "text" <~~ json
    }
}



