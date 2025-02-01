//
//  TimerViewModel.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/29/25.
//

import Combine
import Foundation
import UIKit

@MainActor
@Observable
class TimerViewModel {
    private var timerCancellable: Cancellable?
    
    var startTime: TimeInterval = 0
    var elapsedTime: TimeInterval = 0 {
        didSet {
            update.send(elapsedTime)
        }
    }
    
    var isRunning: Bool = false
    var isPaused: Bool = false
    var isStopped: Bool { !isRunning && !isPaused }

    var update = PassthroughSubject<TimeInterval, Never>()
    
    func start() {
        if isPaused {
            startTime = Date.now.timeIntervalSince1970 - elapsedTime
            isPaused = false
        } else {
            startTime = Date.now.timeIntervalSince1970
            elapsedTime = 0
        }
        timerCancellable = Timer.publish(every: 0.05, on: .main, in: .default)
            .autoconnect()
            .map { $0.timeIntervalSince1970 - self.startTime }
            .assign(to: \.elapsedTime, on: self)
        isRunning = true
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func stop() {
        cancel()
        elapsedTime = 0
        isPaused = false
    }
    
    func pause() {
        isPaused = true
        cancel()
    }
    
    func cancel() {
        timerCancellable?.cancel()
        isRunning = false
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func toggle() {
        isRunning ? pause() : start()
    }
}
