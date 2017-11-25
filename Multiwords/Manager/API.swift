//
//  File.swift
//  Multiwords
//
//  Created by Алина Князева on 07.11.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

class DictAPI {
    
    private init() { }
    
    static let shared = DictAPI.init()
    
    struct Configuration {
        fileprivate static let key = "dict.1.1.20171107T141416Z.b4c03cfa10c44d62.561ed8eeaf0f92aba42b9fdc4757aa8ad7547e00"
    }
    
    func lookup (text: String,
                 from: Language,
                 to: Language,
                 completion: @escaping ([Definition]?, Error?) -> ()) {
        
        let url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup"
        let params = ["key" : Configuration.key,
                      "lang" : "\(from.rawValue)-\(to.rawValue)",
            "text" : text
        ]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            
            switch response.result {
            case .success (let value):
                if let json = value as? JSON, let jsonDefs = json["def"] as? [JSON], let defs = [Definition].from(jsonArray: jsonDefs) {
                    completion(defs, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
}
