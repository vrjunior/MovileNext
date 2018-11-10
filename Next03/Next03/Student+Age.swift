//
//  Student+Age.swift
//  Next03
//
//  Created by Valmir Junior on 10/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

extension Student {
    var age: Int {
        if let birthday = self.birthday {
            return Calendar.current.dateComponents([.year], from: birthday, to: Date()).year ?? 0
        }
        
        return 0
    }
}
