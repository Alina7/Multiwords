//
//  WordsTableViewCell.swift
//  Multiwords
//
//  Created by Алина Князева on 23.10.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import UIKit

class WordsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var translate: UILabel!
    
    var wordsDataShow: Word? {
        didSet {
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    func configureCell() {
        word.text = wordsDataShow?.word
        translate.text = wordsDataShow?.translate
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



