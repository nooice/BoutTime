//
//  ViewController.swift
//  BoutTime
//
//  Created by Kalvin Bunn on 5/1/17.
//  Copyright © 2017 Kalvin Bunn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentRound = 0
    var correctAnswer = 0
    var counter = 0
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var factList: listOfFacts
    var item1: EventItem
    var item2: EventItem
    var item3: EventItem
    var item4: EventItem
    var itemTemp: EventItem
    var hasShaked = false
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let stringOfFacts = try factBuilder.buildFact(fromDictionary: arrayOfEvents)
            self.factList = listOfFacts(fromGroup: stringOfFacts)
            self.factList.shuffleArray()
            guard let itemInit = try factList.pickFacts(from: 0) else {
                throw (FactError.invalidSelection)
            }
            self.item1 = itemInit
            self.item2 = itemInit
            self.item3 = itemInit
            self.item4 = itemInit
            self.itemTemp = itemInit
        } catch let error {
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var fact1: UILabel!
    @IBOutlet weak var fact2: UILabel!
    @IBOutlet weak var fact3: UILabel!
    @IBOutlet weak var fact4: UILabel!
    @IBOutlet weak var topDownButton: UIButton!
    @IBOutlet weak var secondButtonUp: UIButton!
    @IBOutlet weak var secondButtonDown: UIButton!
    @IBOutlet weak var thirdButtonUp: UIButton!
    @IBOutlet weak var thirdButtonDown: UIButton!
    @IBOutlet weak var bottomUpButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var EndGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        postNewFacts()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func loadItem(from number: Int) throws -> EventItem {
        guard let theItem = try factList.pickFacts(from: number) else {
            throw FactError.invalidType
        }
        print(counter)
        counter += 1
        return theItem
    }
    
    func postNewFacts(){
        do {
            EndGameButton.isHidden = true
            submitButton.isHidden = false
            submitButton.isEnabled = false
            item1 = try loadItem(from: counter)
            fact1.text = item1.event
            item2 = try loadItem(from: counter)
            fact2.text = item2.event
            item3 = try loadItem(from: counter)
            fact3.text = item3.event
            item4 = try loadItem(from: counter)
            fact4.text = item4.event
            resetTimer()
        } catch {
            print(FactError.invalidSelection)
        }
    }
    func updateLabels() {
        fact1.text = item1.event
        fact2.text = item2.event
        fact3.text = item3.event
        fact4.text = item4.event
    }
    func disableArrows() {
        topDownButton.isEnabled = false
        secondButtonUp.isEnabled = false
        secondButtonDown.isEnabled = false
        thirdButtonUp.isEnabled = false
        thirdButtonDown.isEnabled = false
        bottomUpButton.isEnabled = false
        submitButton.isEnabled = true
    }
    func enableArrows() {
        topDownButton.isEnabled = true
        secondButtonUp.isEnabled = true
        secondButtonDown.isEnabled = true
        thirdButtonUp.isEnabled = true
        thirdButtonDown.isEnabled = true
        bottomUpButton.isEnabled = true
        submitButton.isEnabled = false
    }
    func resetButtonImage() {
        topDownButton.setImage(#imageLiteral(resourceName: "down_full"), for: .normal)
        secondButtonUp.setImage(#imageLiteral(resourceName: "up_half"), for: .normal)
        secondButtonDown.setImage(#imageLiteral(resourceName: "down_half"), for: .normal)
        thirdButtonUp.setImage(#imageLiteral(resourceName: "up_half"), for: .normal)
        thirdButtonDown.setImage(#imageLiteral(resourceName: "down_half"), for: .normal)
        bottomUpButton.setImage(#imageLiteral(resourceName: "up_full"), for: .normal)
    }
    func resetGame() {
        counter = 0
        correctAnswer = 0
        currentRound = 0
        submitButton.setImage(nil, for: .normal)
        enableArrows()
        resetButtonImage()
        timerLabel.isHidden = false
        hasShaked = false
        resetTimer()
        factList.shuffleArray()
        postNewFacts()
    }
    
    func checkAnswers() {
        currentRound += 1
            if (item1.date < item2.date && item2.date < item3.date && item3.date < item4.date) {
                disableArrows()
                correctAnswer += 1
                resetButtonImage()
                submitButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
            } else{
                disableArrows()
                resetButtonImage()
                submitButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
            }
        if (currentRound == 6){
            timerLabel.isHidden = true
            EndGameButton.isHidden = false
            submitButton.isEnabled = false
        }
    }

    @IBAction func firstItemDown(_ sender: Any) {
        resetButtonImage()
        topDownButton.setImage(#imageLiteral(resourceName: "down_full_selected"), for: .normal)
        itemTemp = item2
        item2 = item1
        item1 = itemTemp
        updateLabels()
    }
    
    @IBAction func secondItemUp(_ sender: Any) {
        resetButtonImage()
        secondButtonUp.setImage(#imageLiteral(resourceName: "up_half_selected"), for: .normal)
        itemTemp = item2
        item2 = item1
        item1 = itemTemp
        updateLabels()
    }
    
    @IBAction func secondItemDown(_ sender: Any) {
        resetButtonImage()
        secondButtonDown.setImage(#imageLiteral(resourceName: "down_half_selected"), for: .normal)
        itemTemp = item3
        item3 = item2
        item2 = itemTemp
        updateLabels()
    }
    
    @IBAction func thirdItemUp(_ sender: Any) {
        resetButtonImage()
        thirdButtonUp.setImage(#imageLiteral(resourceName: "up_half_selected"), for: .normal)
        itemTemp = item3
        item3 = item2
        item2 = itemTemp
        updateLabels()
    }
    
    @IBAction func thirdItemDown(_ sender: Any) {
        resetButtonImage()
        thirdButtonDown.setImage(#imageLiteral(resourceName: "down_half_selected"), for: .normal)
        itemTemp = item4
        item4 = item3
        item3 = itemTemp
        updateLabels()
    }
    
    @IBAction func bottomItemUp(_ sender: Any) {
        resetButtonImage()
        bottomUpButton.setImage(#imageLiteral(resourceName: "up_full_selected"), for: .normal)
        itemTemp = item4
        item4 = item3
        item3 = itemTemp
        updateLabels()
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if hasShaked == false {
            checkAnswers()
            hasShaked = true
            timer.invalidate()
            isTimerRunning = false
            timerLabel.text = "\(0)"
        }
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        submitButton.setImage(nil, for: .normal)
        enableArrows()
        postNewFacts()
        resetButtonImage()
        hasShaked = false
        resetTimer()
        print(counter)
    }
    @IBAction func ShowScore(_ sender: Any) {
        if currentRound == 0 {
            resetGame()
        }else {
            performSegue(withIdentifier: "showScore", sender: String(describing: correctAnswer))
            currentRound = 0
            counter = 0
            correctAnswer = 0
            EndGameButton.setTitle("Reset Game", for: .normal)
            submitButton.isHidden = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showScore" {
            if let destination = segue.destination as? PlayAgainControllerViewController{
                if let unwrappedSender = sender as? String{
                    destination.stringPassed = unwrappedSender
                }
            }
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            checkAnswers()
            hasShaked = true
        }else {
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
    }
    
    func resetTimer() {
        seconds = 60
        timerLabel.text = "\(seconds)"
        if isTimerRunning == false {
            runTimer()
        }
    }
}

