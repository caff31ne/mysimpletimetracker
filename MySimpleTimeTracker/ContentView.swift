//
//  ContentView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    enum Tabs: Equatable, Hashable {
        case focus
        case manual
        case tasks
        case stats
    }
    
    @State private var tab = Tabs.focus
    
    var body: some View {
        
        TabView(selection: $tab) {
            Tab("Focus", systemImage: "timer", value: .focus) {
                FocusView()
            }
            
            Tab("Stopwatch", systemImage: "stopwatch", value: .manual) {
                StopwatchView()
            }
            
            Tab("Tasks", systemImage: "checkmark.seal.text.page", value: .tasks) {
                TasksView()
            }
            
            /* Tab("Statistics", systemImage: "chart.bar", value: .stats) {
                StatsView()
            } */
        }
        .tint(Color.orange)
    }
}

#Preview {
    ContentView()
}
