//
//  FocusViewModel.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/17/25.
//

import Combine
import Foundation
import SwiftData
import UIKit
import UserNotifications

@MainActor
@Observable
final class FocusViewModel: ObservableObject {
    
    var task: TaskAssignment? {
        didSet {
            Settings.shared.focusTaskId = task?.id
        }
    }
    
    var history: [FocusInterval] = []
    
    private var timerCancellable: Cancellable?
    
    var activeIntervalType = FocusIntervalType.shortRest
    
    var duration: TimeInterval = 0
    
    var time: String = "25:00"
    var timer = TimerViewModel()
    
    var progress: TimeInterval { timer.elapsedTime / duration }
    
    var isWork: Bool { activeIntervalType == .work }
    var isShortRest: Bool { activeIntervalType == .shortRest }
    var isLongRest: Bool { activeIntervalType == .longRest }
    
    var modelContext: ModelContext?
    
    private var updateCancellable: AnyCancellable?
    
    init() {
        updateCancellable = timer.update.sink {
            if $0 > self.duration {
                self.timer.elapsedTime = self.duration
                self.done()
            }
            self.updateTime()
        }
        setActiveInterval(.work)
    }
    
    func activate(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        if let assignedTaskId = Settings.shared.focusTaskId {
            let fetchDecriptor = FetchDescriptor<TaskAssignment>(predicate: #Predicate { $0.id == assignedTaskId})
            do {
                let tasks = try modelContext.fetch(fetchDecriptor)
                task = tasks.first
            } catch {
                print("Error fetching task assignment: \(error)")
            }
        }
    }
    
    func setActiveInterval(_ type: FocusIntervalType) {
        guard activeIntervalType != type else { return }
        
        if timer.isRunning {
            timer.cancel()
        }
        
        activeIntervalType = type
        timer.isPaused = false
        duration = Settings.shared.duration(type)
        timer.elapsedTime = 0
    }
    
    func done() {
        recordCurrentInterval()
        timer.stop()
        playNotificationSound()
        next()
    }
    
    func increaseDuration() {
        guard !timer.isPaused else {
            fatalError("Should not be paused when changing interval")
        }
        
        duration += 60
        updateTime()
    }
    
    func decreaseDuration() {
        guard !timer.isPaused else {
            fatalError("Should not be paused when changing interval")
        }
        
        if duration > 60 {
            duration -= 60
        }
        updateTime()
    }
    
    private func next() {
        switch activeIntervalType {
        case .work:
            setActiveInterval(.shortRest)
        case .shortRest:
            setActiveInterval(.work)
        case .longRest:
            setActiveInterval(.work)
        }
    }
    
    private func completeNotificationText(_ intervalType: FocusIntervalType) -> String {
        switch intervalType {
        case .work:
            return "Work period complete"
        case .shortRest:
            return "Short rest period complete"
        case .longRest:
            return "Long rest period complete"
        }
    }
    
    private func playNotificationSound() {
        let notification = UNMutableNotificationContent()
        notification.title = "Focus"
        notification.body = completeNotificationText(activeIntervalType)
        notification.sound = .default
     
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "com.bondur.mysimpletimetracker.focus.done", content: notification, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {
            if let error = $0 {
                print("Nofication request failed: \(error)")
            }
        }
    }
    
    private func recordCurrentInterval() {
        let record = FocusInterval(
            startTime: Date(timeIntervalSince1970: timer.startTime),
            duration: duration,
            type: activeIntervalType,
            task: task)
        modelContext?.insert(record)
        
        if let task = task, activeIntervalType == .work {
            task.focusTime += duration
            task.focusCount += 1
        }
    }
    
    private func updateTime() {
        time = (duration - timer.elapsedTime).asFormattedTime()
    }
}

