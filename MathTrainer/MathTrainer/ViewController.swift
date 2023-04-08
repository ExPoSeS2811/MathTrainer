//
//  ViewController.swift
//  MathTrainer
//
//  Created by MacBook Pro 13 2019 on 3/30/23.
//

import UIKit

class ViewController: UIViewController{
    // MARK: - IBOutlets
    @IBOutlet var countAnswersLabelCollection: [UILabel]!
    @IBOutlet var buttonsCollection: [UIButton]!
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    private var totalRightAnswers: [MathTypes: Int] = [.add: 0, .subtract: 0, .multiply: 0, .divide: 0]
<<<<<<< HEAD
    private var defaultColor: UIColor = UIColor(hex: "f9d423")
    
=======
    private let defaultColor: UIColor = UIColor(hex: "f9d423")


>>>>>>> 9e10ae8 (Prepare)
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
            viewController.viewModel.delegate = self
            viewController.viewModel.type = selectedType
        }
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
    }
    
    private func configureButtons() {
<<<<<<< HEAD
        // Add shadow + default color
=======
>>>>>>> 9e10ae8 (Prepare)
        buttonsCollection.forEach {
            $0.backgroundColor = defaultColor
            $0.addShadow()
        }
    }
}

// MARK: - TrainViewControllerDelegate
extension ViewController: TrainViewControllerDelegate {
    func passData() {
        let indexAnswerLabel = selectedType.rawValue
        if let rightAnswers = totalRightAnswers[selectedType] {
            totalRightAnswers[selectedType] = rightAnswers + 1
            countAnswersLabelCollection[indexAnswerLabel].text = String(totalRightAnswers[selectedType]!)
        }
    }
}
