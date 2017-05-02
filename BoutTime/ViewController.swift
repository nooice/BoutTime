//
//  ViewController.swift
//  BoutTime
//
//  Created by Kalvin Bunn on 5/1/17.
//  Copyright © 2017 Kalvin Bunn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentRound = 1
    var counter = 0
    var shuffledArray = ShuffledArray()
    
    @IBOutlet weak var fact1: UILabel!
    @IBOutlet weak var fact2: UILabel!
    @IBOutlet weak var fact3: UILabel!
    @IBOutlet weak var fact4: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        postFact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func postFact() {
            do{
                try fact1.text = shuffledArray.getFact(number: counter)
                counter += 1
                try fact2.text = shuffledArray.getFact(number: counter)
                counter += 1
                try fact3.text = shuffledArray.getFact(number: counter)
                counter += 1
                try fact4.text = shuffledArray.getFact(number: counter)
                counter += 1
            }catch FactError.missingArray{
                print(FactError.missingArray)
            }catch{}
    }
    
}

