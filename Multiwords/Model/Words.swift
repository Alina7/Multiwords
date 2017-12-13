//
//  Words.swift
//  Multiwords
//
//  Created by Алина Князева on 23.10.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import UIKit
import Foundation

class Word {
    
    var word : String?
    var translate : String?
    var jsonStr : String?
    
    init(word: String, translate: String, jsonStr:String){
        
        self.jsonStr = jsonStr
        self.word = word
        self.translate = translate
    }
}


