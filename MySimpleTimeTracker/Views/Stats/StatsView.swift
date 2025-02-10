//
//  StatsView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 2/10/25.
//

import SwiftUI

struct StatsView: View {
    
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView(selectedDate: $selectedDate)
                DailyTaskSummaryView(selectedDate: selectedDate)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Log")
                        .font(.custom("RussoOne-Regular", size: 24))
                        .bold()
                        .padding()
                        .foregroundColor(Color(white: 0.3))
                }
            }
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    StatsView()
}
