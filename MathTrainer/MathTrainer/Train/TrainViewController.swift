//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by MacBook Pro 13 2019 on 3/30/23.
//

import UIKit

<<<<<<< HEAD
protocol TrainViewControllerDelegate: AnyObject {
    func passData()
=======
protocol TrainViewControllerDelegate: class {
    func passData(with count: Int)
>>>>>>> 9e10ae8 (Prepare)
}

final class TrainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var countCorrectAnswersLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: - Properties
<<<<<<< HEAD
    let viewModel = TrainViewModel()
=======
    private let viewModel = TrainViewModel()
    
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
>>>>>>> 9e10ae8 (Prepare)
    
    private let correctAnswerColor: UIColor = UIColor(hex: "3fff7c")
    private let incorrectAnswerColor: UIColor = UIColor(hex: "fe3d6c")
    private let defaultColor: UIColor = UIColor(hex: "f9d423")
    
<<<<<<< HEAD
=======
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
    
>>>>>>> 9e10ae8 (Prepare)
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShadow()
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
<<<<<<< HEAD
    private func addShadow() {
        [leftButton, rightButton].forEach { $0.addShadow() }
    }
    
=======
>>>>>>> 9e10ae8 (Prepare)
    private func configureButtons() {
        leftButton.backgroundColor = defaultColor
        rightButton.backgroundColor = defaultColor
        
<<<<<<< HEAD
        var buttonProperties = viewModel.getRandomAnswer()
        
        rightButton.setTitle(buttonProperties.isRightAnswer ? buttonProperties.answer : buttonProperties.randomAnswer, for: .normal)
        leftButton.setTitle(buttonProperties.isRightAnswer ? buttonProperties.randomAnswer : buttonProperties.answer, for: .normal)
        
    }
    
    private func configureQuestion() {
        countCorrectAnswersLabel.text = String(viewModel.count)
        questionLabel.text = viewModel.getQuestion()
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == viewModel.answer
        button.backgroundColor = isRightAnswer ? correctAnswerColor : incorrectAnswerColor
        
        if isRightAnswer {
            let isSecondAttempt: Bool = rightButton.backgroundColor == incorrectAnswerColor ||
                                        leftButton.backgroundColor == incorrectAnswerColor
            viewModel.checkAnswer(isSecondAttempt)
            
            leftButton.isEnabled = false
            rightButton.isEnabled = false
            leftButton.setTitleColor(UIColor.black, for: .disabled)
            rightButton.setTitleColor(UIColor.black, for: .disabled)
=======
        let isRightButton = Bool.random()
        let randomAnswer = viewModel.getRandomAnswer()
        
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
    }
    
    private func addShadow() {
        [leftButton, rightButton].forEach { $0?.addShadow() }
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
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? correctAnswerColor : incorrectAnswerColor
        
        if isRightAnswer {
            let isSecondAttempt: Bool = rightButton.backgroundColor == incorrectAnswerColor || leftButton.backgroundColor == incorrectAnswerColor
            if !isSecondAttempt {
                count +=  1
                delegate?.passData(with: 1)
            }
            
            leftButton.isEnabled = false
            rightButton.isEnabled = false
>>>>>>> 9e10ae8 (Prepare)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.leftButton.isEnabled = true
                self?.rightButton.isEnabled = true
<<<<<<< HEAD

                
                self?.configureQuestion()
                self?.configureButtons()
                
=======
                
                self?.configureQuestion()
                self?.configureButtons()
>>>>>>> 9e10ae8 (Prepare)
            }
        }
    }
}
