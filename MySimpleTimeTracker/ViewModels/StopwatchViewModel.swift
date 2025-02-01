//
//  StopwatchViewModel.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/26/25.
//

import Combine
import Foundation
import SwiftData

@MainActor
@Observable
final class StopwatchViewModel: ObservableObject {
    
    var task: TaskAssignment? {
        didSet {
            Settings.shared.stopwatchTaskId = task?.id
        }
    }
    
    var history: [CustomInterval] = []
    
    var time: String = "00:00"
    
    var timer = TimerViewModel()
    
    var modelContext: ModelContext?
    
    private var updateCancellable: AnyCancellable?
    
    init() {
        updateCancellable = timer.update.sink {
            self.time = $0.asFormattedTime()
        }
    }
    
    func activate(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        if let assignedTaskId = Settings.shared.stopwatchTaskId {
            let fetchDecriptor = FetchDescriptor<TaskAssignment>(predicate: #Predicate { $0.id == assignedTaskId})
            do {
                let tasks = try modelContext.fetch(fetchDecriptor)
                task = tasks.first
            } catch {
                print("Error fetching task assignment: \(error)")
            }
        }
    }
    
    func done() {
        recordCurrentInterval()
        timer.stop()
    }
    
    private func recordCurrentInterval() {
        let record = CustomInterval(
            startTime: Date(timeIntervalSince1970: timer.startTime),
            duration: timer.elapsedTime,
            task: task)
        modelContext?.insert(record)
        
        if let task = task {
            task.stopwatchTime += timer.elapsedTime
        }
    }
}

