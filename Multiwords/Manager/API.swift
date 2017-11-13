//
//  File.swift
//  Multiwords
//
//  Created by Алина Князева on 07.11.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias JSON = [String: Any]

class API {
    
    private let KEYTranslate = "trnsl.1.1.20171025T153906Z.49e5318b1693d864.412ddf90fcd51b5990dba3e053585e1f6c111c6b"
    
    private let KEYDictionary = "dict.1.1.20171107T141416Z.b4c03cfa10c44d62.561ed8eeaf0f92aba42b9fdc4757aa8ad7547e00"

    private func getDictURL(from: String, to: String, text: String) -> String {
        return "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=" +
            KEYDictionary + "&lang=" + from + "-" + to + "&text=" + text
    }

    private func getTranslateURL(from: String, to: String, text: String) -> String {
        return "https://translate.yandex.net/api/v1.5/tr.json/translate" +
               "?key=" + KEYTranslate + "&text=" + text + "&lang=" + from + "-" + to
    }
    
    public func dictionaryWord(from: String, to: String, text: String, completionHandler: @escaping ([String]) -> ()) {
        let URL = getDictURL(from: from, to: to, text: text)
        makeRequest(URL) { response, error in
            print(response)
            //completionHandler(response!["text"]! as! [String])
        }
    }
    
    public func translateWord(from: String, to: String, text: String, completionHandler: @escaping ([String]) -> ()) {
        let URL = getTranslateURL(from: from, to: to, text: text)
        makeRequest(URL) { response, error in
            completionHandler(response!["text"]! as! [String])
        }
    }
    
    private func makeRequest(_ URL: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        Alamofire.request(URL, encoding: JSONEncoding.default)
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
}


enum Multiwords {
    
    case translate
}

