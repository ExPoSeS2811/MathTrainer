//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by MacBook Pro 13 2019 on 3/30/23.
//

import UIKit

protocol TrainViewControllerDelegate: class {
    func passData(with count: Int)
}

final class TrainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var countCorrectAnswersLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: TrainViewControllerDelegate?
    
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
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign = ""
    private var count: Int = 0 {
        didSet {
            countCorrectAnswersLabel.text = String(count)
        }
    }
    
    private let correctAnswerColor: UIColor = UIColor(hex: "3fff7c")
    private let incorrectAnswerColor: UIColor = UIColor(hex: "fe3d6c")
    private let defaultColor: UIColor = UIColor(hex: "f9d423")
    
    private var answer: Int {
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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureQuestion()
        configureButtons()
    }
    
    // MARK: - IBActions
    
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    // MARK: - Methods
    private func addShadow() {
        [leftButton, rightButton].forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 2)
            button?.layer.shadowOpacity = 0.8
            button?.layer.shadowRadius = 3
        }
    }
    
    private func configureButtons() {
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
        
        leftButton.backgroundColor = .systemYellow
        leftButton.backgroundColor = .systemYellow
        
    }
    
    private func configureQuestion() {
        // Improved division
        if type == .divide {
            repeat {
                firstNumber = Int.random(in: 2...99)
                secondNumber = Int.random(in: 2...firstNumber)
            } while firstNumber % secondNumber != 0 || firstNumber == secondNumber
        } else {
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
        }
        
        questionLabel.text = "\(firstNumber) \(sign) \(secondNumber) ="
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? correctAnswerColor : incorrectAnswerColor
        
        if isRightAnswer {
            var isSecondAttempt: Bool = rightButton.backgroundColor == incorrectAnswerColor || leftButton.backgroundColor == incorrectAnswerColor
            if !isSecondAttempt {
                count +=  1
                delegate?.passData(with: 1)
            }
            
            leftButton.isEnabled = true
            rightButton.isEnabled = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
                
                self?.leftButton.isEnabled = false
                self?.rightButton.isEnabled = false
            }
        }
    }
}
