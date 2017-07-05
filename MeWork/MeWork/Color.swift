//
//  Color.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 6/22/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

enum Color: String {
    
    case green
    case red
    case pink
    case orange
    case yellow
    case blue
    case purple
    case navBarBlue
    
    func color() -> UIColor {
        
        switch self {
            
        case .green: return UIColor(red: 108/255, green: 204/255, blue: 152/255, alpha: 1.0)
        
        case .red: return UIColor(red: 242/255, green: 99/255, blue: 96/255, alpha: 1.0)
            
        case .pink: return UIColor(red: 255/255, green: 96/255, blue: 152/255, alpha: 1.0)
            
        case .orange: return UIColor(red: 255/255, green: 173/255, blue: 107/255, alpha: 1.0)
        
        case .yellow: return UIColor(red: 244/255, green: 233/255, blue: 132/255, alpha: 1.0)
        
        case .blue: return UIColor(red: 119/255, green: 186/255, blue: 244/255, alpha: 1.0)
            
        case .purple: return UIColor(red: 178/255, green: 164/255, blue: 252/255, alpha: 1.0)
            
        case .navBarBlue: return UIColor(red: 70/255, green: 156/255, blue: 227/255, alpha: 1.0)
            
        }
        
    }
    
    static let allColors = [green, red, pink, orange, yellow, blue, purple]
    
}
