//
//  Item.swift
//  CheatDay
//
//  Created by 齊藤広樹 on 12/8/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
