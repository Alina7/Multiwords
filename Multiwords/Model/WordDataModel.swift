//
//  WordDataModel.swift
//  Multiwords
//
//  Created by Алина Князева on 04.12.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import CoreData

class WordDataModel: NSObject {
    let EntityName = String(describing: Words.self)
    var EntityObject: Words?
    var inEng: String?
    var inRus: String?
    var numFails: Int
    var numPass: Int
    var translationIndex: Int
    var origJSON:String?
    var defObject:Definition?
    
    
    static func getAllWords() -> Array<WordDataModel> {
        var retArray:Array<WordDataModel> = Array()
        
        let fetchRequest:NSFetchRequest<Words> = Words.fetchRequest()
        
        do{
            let sort = NSSortDescriptor(key: #keyPath(Words.engWord), ascending: true)
            fetchRequest.sortDescriptors = [sort]
            let words = try DatabaseController.getContext().fetch(fetchRequest)
            print("WDM getAllWords count is \(words.count)")
            for word in words {
                retArray.append(WordDataModel(withEntityObject: word))
            }
        }
        catch{
            print("Error: \(error.localizedDescription)")
        }
        
        return retArray
    }
    
    func save() -> Bool {
        
        if EntityObject == nil {
            return insertWord()
        }else{
            return updateWord()
        }
        
    }
    
    private func insertWord() -> Bool {
        EntityObject = (NSEntityDescription.insertNewObject(forEntityName: EntityName, into: DatabaseController.getContext()) as! Words)
        return updateWord()
    }
    
    private func updateWord() -> Bool {
        if setDataToEntityObject(){
            DatabaseController.saveContext()
            return true
        }else{
            return false
        }
    }
    
    
    func delete() -> Bool {
        if EntityObject != nil {
            DatabaseController.getContext().delete(EntityObject!)
            do{
                try DatabaseController.saveContext()
            }
            catch{
                print("Error \(error.localizedDescription)")
            }
            EntityObject = nil
            return true
        }
        else{
            return false
        }
        
    }
    
    override init() {
        self.inRus = nil
        self.inEng = nil
        self.numFails = 0
        self.numPass = 0
        self.translationIndex = 0
        super.init()
    }
    
    init(withEntityObject: Words) {
        self.EntityObject = withEntityObject
        self.inEng = withEntityObject.engWord!
        self.inRus = withEntityObject.rusWord!
        self.numPass = Int(withEntityObject.testsPassed)
        self.numFails = Int(withEntityObject.testsFailed)
        self.origJSON = withEntityObject.originalJSON
        self.translationIndex = Int(withEntityObject.translationIndex)
        super.init()
    }
    
    private func setDataToEntityObject() -> Bool {
        
        EntityObject?.engWord = self.inEng
        EntityObject?.rusWord = self.inRus
        EntityObject?.testsFailed = Int64(self.numFails)
        EntityObject?.testsPassed = Int64(self.numPass)
        EntityObject?.translationIndex = Int64(self.translationIndex)
        if(self.defObject == nil){
            EntityObject?.originalJSON = self.origJSON
        }else{
            EntityObject?.originalJSON = self.defObject?.toString()
            self.origJSON = self.defObject?.toString()
        }
        
        return true
    }
}

