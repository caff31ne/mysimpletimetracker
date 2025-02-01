//
//  IntervalRecord.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/17/25.
//

import Foundation
import SwiftData

@Model
final class FocusInterval {
    
    var startTime: Date
    var duration: TimeInterval
    var type: FocusIntervalType
    var task: TaskAssignment?
    
    init(startTime: Date, duration: TimeInterval, type: FocusIntervalType, task: TaskAssignment?) {
        self.startTime = startTime
        self.duration = duration
        self.type = type
        self.task = task
    }
}
