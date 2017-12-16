//
//  TestConteinerViewController.swift
//  Multiwords
//
//  Created by Алина Князева on 16.12.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var NumOfWordsLabel: UILabel!
    @IBOutlet weak var Stepper: UIStepper!
    @IBAction func StrpperValueChanged(_ sender: UIStepper) {
        
        NumOfWordsLabel.text = "Количество слов: \(Int(sender.value))"
        UserDefaults.standard.set(Int(sender.value), forKey: "MaxNumOfWords")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NumOfWordsLabel.text = "Количество слов: \(UserDefaults.standard.integer(forKey: "MaxNumOfWords"))"
        Stepper.value = Double( UserDefaults.standard.integer(forKey: "MaxNumOfWords"))
    }
}

