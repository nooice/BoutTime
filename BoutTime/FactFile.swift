//
//  FactFile.swift
//  BoutTime
//
//  Created by Kalvin Bunn on 5/1/17.
//  Copyright © 2017 Kalvin Bunn. All rights reserved.
//

import Foundation
import GameKit

let arrayOfEvents: [[String:String]] = [
    ["event": "Declaration of Independence was signed", "date": "1776"],
    ["event": "Donald Trump sworn in as President", "date": "2017"],
    ["event": "Man lands on Moon", "date": "1969"],
    ["event": "Disneyland Theme Park opens", "date": "1955"],
    ["event": "Attack on Pearl Harbor", "date": "1941"],
    ["event": "Elvis Presley dies", "date": "1977"],
    ["event": "construction of the US White House begins", "date": "1792"],
    ["event": "Berlin Wall falls", "date": "1989"],
    ["event": "Amelia Earhart disappears", "date": "1937"],
    ["event": "First Season of American idol", "date": "2002"],
    ["event": "First Official Television Broadcast", "date": "1954"],
    ["event": "Dr Pepper founded", "date": "1885"],
    ["event": "Twin Towers attacked", "date": "2001"],
    ["event": "Ghandi dies", "date": "1948"],
    ["event": "Apple founded", "date": "1976"],
    ["event": "Beyonce gives birth to Blue Ivy", "date": "2012"],
    ["event": "Harry Potter and the Philosophers stone released", "date": "1997"],
    ["event": "RMS Titanic sinks", "date": "1912"],
    ["event": "Pokemon Go released", "date": "2016"],
    ["event": "Michael Jackson Died", "date": "2009"],
    ["event": "Who let the dogs out released", "date": "2000"],
    ["event": "Nixon Impeached", "date": "1974"],
    ["event": "First Thanksgiving", "date": "1619"],
    ["event": "Siri introduced", "date": "2011"],
    ["event": "Novel 1984 Published", "date": "1948"]
]

enum FactError: Error {
    case missingArray
}

struct ShuffledArray {
    var newArray: [[String:String]] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayOfEvents) as! [[String : String]]
    
    mutating func shuffleAgain(){
        newArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayOfEvents) as! [[String : String]]
    }
    
    func getFact(number: Int) throws -> String? {
        guard let event = newArray[number]["event"] else {
            throw FactError.missingArray
        }
        return event
    }
}
