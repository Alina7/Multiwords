//
//  DictonaryTableViewController.swift
//  Multiwords
//
//  Created by Алина Князева on 23.10.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import UIKit
import Alamofire

class DictonaryTableViewController: UITableViewController {
    
    @IBOutlet weak var table: UITableView!
    //var api = API()
    var wordsDictonary: [Word] = []
    let tableIdentifier = "cell"
    var selectedWordIndex:Int?
    var allWords:Array<WordDataModel>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.searchBar.delegate = self
       // setupNavigationBar()
    }
    
    
    
    
   func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let SearchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = SearchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchData()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wordsDictonary.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:tableIdentifier , for: indexPath) as! WordsTableViewCell
        cell.wordsDataShow = wordsDictonary[indexPath.row]
        return cell
    }
    
    func fetchData() {
        allWords = WordDataModel.getAllWords()
        wordsDictonary = []
        for word in allWords!{
            wordsDictonary.append(Word(word: word.inEng!, translate: word.inRus!, jsonStr: word.origJSON!))
        }
        table.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            if (allWords?[indexPath.row].delete())! {
                fetchData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordIndex = indexPath.row
        self.performSegue(withIdentifier: "fromDctionaryToDetail", sender: self)
    }
    //self.performSegue(withIdentifier: "fromDctionaryToDetail", sender: self) //fromDctionaryToDetail


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromDctionaryToDetail"){
            let detailView = segue.destination as! DetailWordTableViewController
            detailView.wordObject = allWords?[selectedWordIndex!]
        }
    }
    
}



