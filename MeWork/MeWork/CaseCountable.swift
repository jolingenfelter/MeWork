//
//  CaseCountable.swift
//  MeWork
//
//  Created by Joanna Lingenfelter on 7/4/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

protocol CaseCountable {
    
    static var caseCount: Int { get }
    
}

extension CaseCountable where Self : RawRepresentable, Self.RawValue == Int {
    
    static func countCases() -> Int {
        var count = 0
        while let _ = Self(rawValue: count) { count += 1}
        return count
    }
    
}
