//
//  BMSColor.swift
//  BMS
//
//  Created by Varun Dudeja on 12/04/21.
//

import Foundation
import UIKit

enum BMSColor {
    case red
    
    func getColor() -> UIColor {
        switch self {
        case .red:
            return UIColor.red
        }
    }
}

