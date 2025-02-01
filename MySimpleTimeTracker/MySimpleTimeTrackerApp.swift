//
//  MySimpleTimeTrackerApp.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/16/25.
//

import SwiftUI
import SwiftData
import UserNotifications

@main
struct MySimpleTimeTrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FocusInterval.self,
            TaskAssignment.self,
            CustomInterval.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if !granted {
                print("Can't enable notifications \(String(describing: error))")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
