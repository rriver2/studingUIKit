//
//  Consentration.swift
//  cloneStanford
//
//  Created by 이가은 on 2022/07/08.
//
import Foundation

// model
class Concentration {
    private(set) var cards = [Card]()

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            // 1개만 뒤집혀있을 경우에 return index
            // 2개 혹은 0개일 경우 return nil
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFadeUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            // newValue를 제외한 모든 카드 face down
            for index in cards.indices {
                cards[index].isFadeUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the card)")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check id cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFadeUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards < 0, "Concentration.init(at: \(numberOfPairsOfCards): you must have at least one pair of cards)")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            self.cards += [card, card]
        }
        cards.shuffle()
    }
}
