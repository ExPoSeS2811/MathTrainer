//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by MacBook Pro 13 2019 on 3/30/23.
//

import UIKit

protocol TrainViewControllerDelegate: AnyObject {
    func passData()
}

final class TrainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var countCorrectAnswersLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: - Properties
    let viewModel = TrainViewModel()
    
    private let correctAnswerColor: UIColor = UIColor(hex: "3fff7c")
    private let incorrectAnswerColor: UIColor = UIColor(hex: "fe3d6c")
    private let defaultColor: UIColor = UIColor(hex: "f9d423")
    
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
    private func addShadow() {
        [leftButton, rightButton].forEach { $0.addShadow() }
    }
    
    private func configureButtons() {
        leftButton.backgroundColor = defaultColor
        rightButton.backgroundColor = defaultColor
        
        var buttonProperties = viewModel.getRandomAnswer()
        
        rightButton.setTitle(buttonProperties.isRightAnswer ? String(buttonProperties.answer) : buttonProperties.randomAnswer, for: .normal)
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
            let isSecondAttempt: Bool = rightButton.backgroundColor == incorrectAnswerColor || leftButton.backgroundColor == incorrectAnswerColor
            viewModel.checkAnswer(isSecondAttempt)
            
            leftButton.isEnabled = false
            rightButton.isEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.leftButton.isEnabled = true
                self?.rightButton.isEnabled = true
                
                self?.configureQuestion()
                self?.configureButtons()
                
            }
        }
    }
}
