//
//  BMSFonts.swift
//  BMS
//
//  Created by Varun Dudeja on 12/04/21.
//

import Foundation
import UIKit

enum BMSFonts {
    case regular
    
    func getFont() -> UIFont {
        switch self {
        case .regular:
            return UIFont(name: "Helvetica", size: 12)!
        }
    }
}

