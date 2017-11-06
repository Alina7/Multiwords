//
//  DictonaryTableViewController.swift
//  Multiwords
//
//  Created by Алина Князева on 23.10.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import UIKit

class DictonaryTableViewController: UITableViewController {
    
    var wordsDictonary: [Word] = []
    let tableIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        wordsDictonary.append(Word(word: "Hello", translate: "Привет"))
        wordsDictonary.append(Word(word: "Purpose", translate: "Цель"))
        wordsDictonary.append(Word(word: "Opposite", translate: "Против"))
    }
}



