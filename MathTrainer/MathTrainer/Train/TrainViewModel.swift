//
//  TrainViewModel.swift
//  MathTrainer
//
//  Created by MacBook Pro 13 2019 on 4/8/23.
//

import Foundation

class TrainViewModel {
    
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
            
            self.count = UserDefaults.standard.object(forKey: type.key) as? Int ?? 0
        }
    }
    
    var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign = ""
    private(set) var count: Int = 0 {
        didSet {
            UserDefaults.standard.set(count, forKey: type.key)
        }
    }

    func getRandomAnswer() -> ButtonPropertiesModel {
        var randomAnswer: Int
        
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        return ButtonPropertiesModel(
            isRightAnswer: Bool.random(),
            answer: String(answer),
            randomAnswer: String(randomAnswer)
        )
    }
    
    func getQuestion() -> String {
        if type == .divide {
            repeat {
                firstNumber = Int.random(in: 2...99)
                secondNumber = Int.random(in: 2...firstNumber)
            } while firstNumber % secondNumber != 0 || firstNumber == secondNumber
        } else {
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
        }
        
        return "\(firstNumber) \(sign) \(secondNumber)"
    }
    
    func checkAnswer(_ isSecondAttempt: Bool) {
        if !isSecondAttempt {
            count += 1
        }
    }
    
}

extension UserDefaults {
    static let container = UserDefaults(suiteName: "container")
}
