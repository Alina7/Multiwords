//
//  TestConteinerViewController.swift
//  Multiwords
//
//  Created by Алина Князева on 16.12.2017.
//  Copyright © 2017 Алина Князева. All rights reserved.
//

import Foundation
import UIKit

class TestConteinerViewController: UIViewController {
    
    @IBOutlet weak var AddWordsPrompt: UILabel!
    @IBOutlet weak var OrigWordLabel: UILabel!
    @IBOutlet weak var TranscriptionLabel: UILabel!
    @IBOutlet weak var ChastRechiLabel: UILabel!
    @IBOutlet weak var TestTestEdit: UITextField!
    @IBOutlet weak var CounterLabel: UILabel!
    @IBOutlet weak var CheckButton: UIButton!
    @IBAction func CheckBtn(_ sender: Any) {
        
        let inputedText = TestTestEdit.text
        if wordsToCheck[currentWordIndex].inRus == inputedText {
            wordsToCheck[currentWordIndex].numPass = wordsToCheck[currentWordIndex].numPass + 1
        }else{
            wordsToCheck[currentWordIndex].numPass = wordsToCheck[currentWordIndex].numFails + 1
        }
        
        wordsToCheck[currentWordIndex].save()
        currentWordIndex = currentWordIndex + 1;
        if currentWordIndex == realNumberOfWordsToCheck {
            loadWordForTest()
            currentWordIndex = 0
        }
        TestTestEdit.text = ""
         setWordToView()
    }
    
    var numberOfWordsToCheck:Int = 5;
    var realNumberOfWordsToCheck:Int = 0
    var currentWordIndex:Int = 0
    var wordsToCheck:Array<WordDataModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        numberOfWordsToCheck = UserDefaults.standard.integer(forKey: "MaxNumOfWords")
        loadWordForTest()
        whatToShow()
        if wordsToCheck.count > 0 {
            setWordToView()
        }
    }
    
    func whatToShow() {
        if wordsToCheck.count == 0 {
            AddWordsPrompt.isHidden = false
            OrigWordLabel.isHidden = true
            TranscriptionLabel.isHidden = true
            TestTestEdit.isHidden = true
            CheckButton.isHidden = true
            CounterLabel.isHidden = true
        }else{
            AddWordsPrompt.isHidden = true
            OrigWordLabel.isHidden = false
            TranscriptionLabel.isHidden = false
            TestTestEdit.isHidden = false
            CheckButton.isHidden = false
            CounterLabel.isHidden = false
        }
    }
    
    func loadWordForTest() {
        wordsToCheck = WordDataModel.getWordsForTest(n: numberOfWordsToCheck)
        realNumberOfWordsToCheck = wordsToCheck.count
    }
    
    func setWordToView() {
        CounterLabel.text = "\(currentWordIndex+1)/\(realNumberOfWordsToCheck)"
        OrigWordLabel.text = wordsToCheck[currentWordIndex].inEng
        TranscriptionLabel.text = "[\(wordsToCheck[currentWordIndex].defObject!.transcription!)]"
        ChastRechiLabel.text = wordsToCheck[currentWordIndex].defObject?.partOfSpeech
    }
}
