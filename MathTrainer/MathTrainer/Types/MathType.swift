//
//  MathType.swift
//  MathTrainer
//
//  Created by MacBook Pro 13 2019 on 4/8/23.
//

import Foundation

enum MathTypes: Int, CaseIterable {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            return "addCount"
        case .subtract:
            return "subtractCount"
        case .multiply:
            return "multiplyCount"
        case .divide:
            return "divideCount"
        }
    }
}
