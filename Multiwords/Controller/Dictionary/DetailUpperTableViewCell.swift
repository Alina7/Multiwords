//
//  DetailUpperTableViewCell.swift
//  Multiwords
//
//  Created by Алина Князева on 11.12.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import UIKit

class DetailUpperTableViewCell: UITableViewCell {

    
    @IBOutlet weak var OrigWordLabel: UILabel!
    @IBOutlet weak var TrascriptionLabel: UILabel!
    @IBOutlet weak var PrefferedTraslationLabel: UILabel!
    @IBOutlet weak var LearnBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
