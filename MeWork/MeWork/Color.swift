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
    
    func color() -> UIColor {
        
        switch self {
            
        case .green: return UIColor(red: 153/255, green: 224/255, blue: 139/255, alpha: 1.0)
        
        case .red: return UIColor(red: 242/255, green: 99/255, blue: 96/255, alpha: 1.0)
            
        case .pink: return UIColor(red: 255/255, green: 96/255, blue: 152/255, alpha: 1.0)
            
        case .orange: return UIColor(red: 255/255, green: 170/255, blue: 73/255, alpha: 1.0)
        
        case .yellow: return UIColor(red: 255/255, green: 233/255, blue: 94/255, alpha: 1.0)
        
        case .blue: return UIColor(red: 119/255, green: 186/255, blue: 244/255, alpha: 1.0)
            
        case .purple: return UIColor(red: 178/255, green: 164/255, blue: 252/255, alpha: 1.0)
            
        }
        
    }
    
}
