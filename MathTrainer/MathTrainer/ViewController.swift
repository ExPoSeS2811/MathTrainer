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
    private var defaultColor: UIColor = UIColor(hex: "f9d423")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        setCountLabels()
    }
    
    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }

    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.viewModel.type = selectedType
        }
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        setCountLabels()
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        for (countLabel, mathType) in zip(countAnswersLabelCollection, MathTypes.allCases) {
            UserDefaults.standard.removeObject(forKey: mathType.key)
            countLabel.text = "-"
            
        }
    }
    
    private func setCountLabels() {
        MathTypes.allCases.forEach { type in
            let key = type.key
            guard let count = UserDefaults.standard.object(forKey: key) as? Int else { return }
            
            switch type {
            case .add:
                countAnswersLabelCollection[0].text = String(count)
            case .subtract:
                countAnswersLabelCollection[1].text = String(count)
            case .multiply:
                countAnswersLabelCollection[2].text = String(count)
            case .divide:
                countAnswersLabelCollection[3].text = String(count)
            }
        }
    }
    
    private func configureButtons() {
        // Add shadow + default color
        buttonsCollection.forEach {
            $0.backgroundColor = defaultColor
            $0.addShadow()
        }
    }
}
