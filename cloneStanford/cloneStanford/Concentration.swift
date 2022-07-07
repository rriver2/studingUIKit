//
//  Consentration.swift
//  cloneStanford
//
//  Created by 이가은 on 2022/07/08.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        // 1) 이전에 1개가 뒤집어져 있을 때
        // matchedIndex != index -> 같은 애 두번 누른 거 방지
        if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
            if cards[matchedIndex].identifier == cards[index].identifier{
                cards[matchedIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFadeUp = true
            indexOfOneAndOnlyFaceUpCard = nil
        } else {
            // 1) 이전에 0개 or 2개가 뒤집어져 있을 때
            for flipDownIndex in cards.indices{
                cards[flipDownIndex].isFadeUp = false
            }
            cards[index].isFadeUp = true
            indexOfOneAndOnlyFaceUpCard = index
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            self.cards += [card, card]
        }
    }
}
