//
//  UIButton+addShadow().swift
//  MathTrainer
//
//  Created by MacBook Pro 13 2019 on 4/8/23.
//

import UIKit

extension UIButton {
    func addShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3
    }
}
