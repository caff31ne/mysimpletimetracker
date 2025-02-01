//
//  TaskAssignment.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/19/25.
//

import Foundation
import SwiftData

@Model
final class TaskAssignment {
    var id: UUID
    var created: TimeInterval
    var title: String
    var complete: Bool
    var focusCount: Int
    var focusTime: TimeInterval
    var stopwatchTime: TimeInterval
    
    init(title: String, complete: Bool = false, focusCount: Int = 0, focusTime: TimeInterval = 0, stopwatchTime: TimeInterval = 0) {
        self.id = UUID()
        self.created = Date().timeIntervalSince1970
        self.title = title
        self.complete = complete
        self.focusCount = focusCount
        self.focusTime = focusTime
        self.stopwatchTime = stopwatchTime
    }
}
