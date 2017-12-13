//
//  DetailWordTableViewController.swift
//  Multiwords
//
//  Created by Алина Князева on 23.10.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import UIKit
import Foundation

class DetailWordTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var DetailTableView: UITableView!
    var word: Definition?
    var indexOfTranslation:Int?
    var wordObject: WordDataModel?
    
    let upperTableViewCelName = "DetailUpperTableViewCell"
    let otherTranslationsCellName = "DetailOtherTranslationsTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("\(word?.toString() ?? "fucked up json(")")
        //print("Definition \(word?.text ?? "is nil")")
        //print("Translation \(word?.translations[indexOfTranslation!].text ?? "is nil")")
        
        let regUpperCell = UINib(nibName: upperTableViewCelName, bundle: nil)
        DetailTableView.register(regUpperCell, forCellReuseIdentifier: upperTableViewCelName)
        
        let regOtherCell = UINib(nibName: otherTranslationsCellName, bundle: nil)
        DetailTableView.register(regOtherCell, forCellReuseIdentifier: otherTranslationsCellName)
        
        self.navigationItem.hidesBackButton = false
        if(wordObject == nil){
            let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(DetailWordTableViewController.saveWord))
                self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        }else{
            indexOfTranslation = wordObject?.translationIndex
            word = Definition(json: Definition.toJSONfrom(myString: (wordObject?.origJSON)!))
        }
        
    }
    
    @objc func saveWord() {
        let newWordModel:WordDataModel = WordDataModel()
        newWordModel.translationIndex = indexOfTranslation!
        newWordModel.defObject = word
        newWordModel.inEng = word?.text
        newWordModel.inRus = word?.translations[indexOfTranslation!].text
        if(newWordModel.save()){
            self.navigationItem.rightBarButtonItem = nil
            print("Saved word")
        }else{
            print("Error seving word")
        }
    }
    
    //MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( section == 0){
            return 1;
        }else if(section == 1){
            return (word?.translations.count)!
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: upperTableViewCelName, for: indexPath) as! DetailUpperTableViewCell
            if(indexPath.row == 0){
                cell.OrigWordLabel.text = self.word?.text
                cell.TrascriptionLabel.text = "[\(self.word!.transcription!)]"
                cell.PrefferedTraslationLabel.text = self.word?.translations[indexOfTranslation!].text
                cell.LearnBtn.isHidden = true
            }else if(indexPath.row == 1){
                cell.OrigWordLabel.isHidden = true
                cell.TrascriptionLabel.isHidden = true
                cell.PrefferedTraslationLabel.isHidden = true
                cell.LearnBtn.isHidden = false
            }
            return  cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: otherTranslationsCellName, for: indexPath) as! DetailOtherTranslationsTableViewCell
            if( indexPath.row == 0 ){
                cell.OtherTranslationsLabel.text = "Другие варианты перевода:"
            }else{
                cell.OtherTranslationsLabel.text = word?.translations[indexPath.row - 1].text
            }
            return  cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
