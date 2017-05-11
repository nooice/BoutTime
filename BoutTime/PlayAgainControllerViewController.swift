//
//  PlayAgainControllerViewController.swift
//  BoutTime
//
//  Created by Kalvin Bunn on 5/1/17.
//  Copyright © 2017 Kalvin Bunn. All rights reserved.
//

import UIKit

class PlayAgainControllerViewController: UIViewController {
    var stringPassed = ""

    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var scoreBoard: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        postScore()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postScore() {
        scoreBoard.text = "\(stringPassed)/6"
        
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
