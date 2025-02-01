//
//  CustomInterval.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/19/25.
//

import Foundation
import SwiftData

@Model
final class CustomInterval {
    var startTime: Date
    var duration: TimeInterval
    var task: TaskAssignment?
    
    init(startTime: Date, duration: TimeInterval, task: TaskAssignment?) {
        self.startTime = startTime
        self.duration = duration
        self.task = task
    }
}
