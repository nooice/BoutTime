//
//  FactFile.swift
//  BoutTime
//
//  Created by Kalvin Bunn on 5/1/17.
//  Copyright © 2017 Kalvin Bunn. All rights reserved.
//

import Foundation
import GameKit

let arrayOfEvents: [String: Dictionary<String, Any>] = [
    "declorationOfIndependence" : ["event": "Declaration of Independence was signed", "date": 1776],
    "donald" : ["event": "Donald Trump sworn in as President", "date": 2017],
    "manOnMoon" : ["event": "Man lands on Moon", "date": 1969],
    "disneyLand" : ["event": "Disneyland Theme Park opens", "date": 1955],
    "pearlHarbor" : ["event": "Attack on Pearl Harbor", "date": 1941],
    "elvis" : ["event": "Elvis Presley dies", "date": 1977],
    "whiteHouse" : ["event": "construction of the US White House begins", "date": 1792],
    "berlinWall" : ["event": "Berlin Wall falls", "date": 1989],
    "amelia" : ["event": "Amelia Earhart disappears", "date": 1937],
    "americanIdol" : ["event": "First Season of American idol", "date": 2002],
    "tvBroadcast" : ["event": "First Official Television Broadcast", "date": 1954],
    "drPepper" : ["event": "Dr Pepper founded", "date": 1885],
    "twinTower" : ["event": "Twin Towers attacked", "date": 2001],
    "ghandi" : ["event": "Ghandi dies", "date": 1948],
    "apple" : ["event": "Apple founded", "date": 1976],
    "queenB" : ["event": "Beyonce gives birth to Blue Ivy", "date": 2012],
    "harryPotter" : ["event": "Harry Potter and the Philosophers stone released", "date": 1997],
    "titanic" : ["event": "RMS Titanic sinks", "date": 1912],
    "pokemon" : ["event": "Pokemon Go released", "date": 2016],
    "mJackson" : ["event": "Michael Jackson Died", "date": 2009],
    "whoLetTheDogsOut" : ["event": "Who let the dogs out released", "date": 2000],
    "nixon" : ["event": "Nixon Impeached", "date": 1974],
    "thanksgiving" : ["event": "First Thanksgiving", "date": 1619],
    "siri" : ["event": "Siri introduced", "date": 2011],
    "novel1984" : ["event": "Novel 1984 Published", "date": 1948]
]

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<arrayOfEvents.count
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

enum FactError: Error {
    case missingArray
    case invalidSelection
    case invalidType
}

protocol EventType {
    var event: String { get }
    var date: Int { get }
}

protocol Listable {
    var listItems: [EventPlaceholder : EventItem] { get set }
    
    init(fromGroup listItems: [EventPlaceholder : EventItem])
}

enum EventPlaceholder: String {
    case declorationOfIndependence
    case donald
    case manOnMoon
    case disneyLand
    case pearlHarbor
    case elvis
    case whiteHouse
    case berlinWall
    case amelia
    case americanIdol
    case tvBroadcast
    case drPepper
    case twinTower
    case ghandi
    case apple
    case queenB
    case harryPotter
    case titanic
    case pokemon
    case mJackson
    case whoLetTheDogsOut
    case nixon
    case thanksgiving
    case siri
    case novel1984
}

struct EventItem: EventType {
    var event: String
    var date: Int
}

//turns a [String : Dictionary] into a object with EventPlaceHolder as the key and EventItem values as the value
//call with a do try factBuilder.buildFact(fromDictionary: _ )
class factBuilder{
    static func buildFact(fromDictionary dictionary: [String : Dictionary<String, Any>]) throws -> [EventPlaceholder: EventItem] {
        
        var newArray: [EventPlaceholder : EventItem] = [:]
        
        for (key, value) in dictionary {
            let eventInfo = value
            if let event = eventInfo["event"] as? String, let date = eventInfo["date"] as? Int{
                let eventItem = EventItem(event: event, date: date)
                
                guard let selection = EventPlaceholder(rawValue: key) else {
                    throw FactError.invalidSelection
                }
                newArray.updateValue(eventItem, forKey: selection)
                
            }
            
        }
        return newArray
    }
}

class listOfFacts: Listable {
    var selection: [EventPlaceholder] = [.declorationOfIndependence, .donald, .manOnMoon, .disneyLand, .pearlHarbor, .elvis, .whiteHouse, .berlinWall, .amelia, .americanIdol, .tvBroadcast, .drPepper, .twinTower, .ghandi, .apple, .queenB, .harryPotter, .titanic, .pokemon, .mJackson, .whoLetTheDogsOut, .nixon, .thanksgiving, .siri, .novel1984]
    var listItems: [EventPlaceholder : EventItem]
    required init(fromGroup listItems: [EventPlaceholder : EventItem]) {
        self.listItems = listItems
    }
    func shuffleArray() {
        selection.shuffle()
    }
    func pickFacts(from number: Int) throws -> EventItem? {
        return listItems[selection[number]]
    }
}
