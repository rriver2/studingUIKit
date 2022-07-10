//
//  ViewController.swift
//  cloneStanford
//
//  Created by 이가은 on 2022/07/08.
//

import UIKit

class ViewController: UIViewController {
    // lazy : 쓰기 전에 init 안됨 -> property observer를 쓸 수 없음
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int { // computed property ( get 생략 )
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet { // property observer
            filpCountLabel.text = "flips : \(flipCount)"
        }
    }
    
    @IBOutlet private weak var filpCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card is not in cardButtons")
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFadeUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }
    
    private var emojiChoices = ["🌷","🔥", "🏞","🍀","🥶","🎉","✨","📚"]
    
    private  var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

// extension으로 랜덤 정수 넘기기
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

