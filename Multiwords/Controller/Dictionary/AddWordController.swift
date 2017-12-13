//
//  AddWordController.swift
//  Multiwords
//
//  Created by Алина Князева on 07.12.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import UIKit

class AddWordController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var AddWordTable: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    var searchActive = false
    var choosenWord: [Definition] = []
    var selectedWord: Definition? = nil
    var selectedTranslation:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskCellNib = UINib(nibName: "DictionaryTableViewCell", bundle: nil)
        AddWordTable.register(taskCellNib, forCellReuseIdentifier: "DictTableCell")
        
        SearchBar.delegate = self
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromAddToDetailView"){
            let wordVC = segue.destination as! DetailWordTableViewController
            wordVC.word = choosenWord
        }
    }*/
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print("Begined edt")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Ended edt")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search go")
        
        let api = DictAPI.shared
        
        api.lookup(text: searchBar.text!, from: .english, to: .russian) {
            def, error in
            if error == nil {
                print("Success!")
                print(def)
                for item in def! {
                    print (item.text)
                    print(item.partOfSpeech)
                    for item2 in item.translations {
                        print(item2.text)
                    }
                    print("   ")
                }

            } else {
                print("Failed with an error: \(error!.localizedDescription)")
            }
            self.choosenWord = def!
            self.AddWordTable.reloadData()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if( self.choosenWord.count == 0){
            return 0;
        } else{
            print ("Num of sections \(self.choosenWord.count)")
            return self.choosenWord.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( self.choosenWord.count == 0){
            return 0;
        } else{
            print ("num of rows \(self.choosenWord[section].translations.count)")
            return self.choosenWord[section].translations.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictTableCell", for: indexPath) as! DictionaryTableViewCell
        cell.bottomLabel.text = self.choosenWord[indexPath.section].translations[indexPath.row].text
        cell.topLabel.text = self.choosenWord[indexPath.section].text
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("Selected index \(indexPath)")
        selectedWord = choosenWord[indexPath.section]
        selectedTranslation = indexPath.row
        self.performSegue(withIdentifier: "fromAddToDetail", sender: self) //fromDctionaryToDetail
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromAddToDetail"){
            let detailView = segue.destination as! DetailWordTableViewController
            detailView.word = selectedWord!
            detailView.indexOfTranslation = selectedTranslation
            
        }
    }
    
    
}
