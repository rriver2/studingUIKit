//
//  Card.swift
//  cloneStanford
//
//  Created by 이가은 on 2022/07/08.
//

import Foundation

// model must be UI Dependence
// 그래서 이모지는 들어가면 안됨
struct Card {
    var isMatched = false
    var isFadeUp = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
