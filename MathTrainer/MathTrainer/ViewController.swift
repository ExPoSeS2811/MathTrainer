//
//  ViewController.swift
//  MathTrainer
//
//  Created by MacBook Pro 13 2019 on 3/30/23.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController{
    // MARK: - IBOutlets
    @IBOutlet var countAnswersLabelCollection: [UILabel]!
    @IBOutlet var buttonsCollection: [UIButton]!
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    private var totalRightAnswers: [MathTypes: Int] = [.add: 0, .subtract: 0, .multiply: 0, .divide: 0]
    private var defaultColor: UIColor = UIColor(hex: "f9d423")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
    }
    
    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }

    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.delegate = self
            viewController.type = selectedType
        }
    }
    
    private func configureButtons() {
        // Add shadow + default color
        buttonsCollection.forEach { button in
            button.backgroundColor = defaultColor
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.8
            button.layer.shadowRadius = 3
        }
    }
}

// MARK: - TrainViewControllerDelegate
extension ViewController: TrainViewControllerDelegate {
    func passData(with count: Int) {
        let indexAnswerLabel = selectedType.rawValue
        if let rightAnswers = totalRightAnswers[selectedType] {
            totalRightAnswers[selectedType] = rightAnswers + count
            countAnswersLabelCollection[indexAnswerLabel].text = String(totalRightAnswers[selectedType]!)
        }
    }
}
