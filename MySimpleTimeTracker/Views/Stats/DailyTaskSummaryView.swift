//
//  DailyTaskSummaryView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 2/10/25.
//

import SwiftData
import SwiftUI

struct DailyTaskSummaryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var records: [FocusInterval]
    
    var selectedDate: Date
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? startOfDay
        
        _records = Query(filter: #Predicate<FocusInterval> {
            $0.startTime >= startOfDay && $0.startTime < endOfDay
        }, sort: \.startTime)
    }
    
    var body: some View {
        List {
            ForEach(records) {
                Text(title($0.type))
                    .font(Font.custom(Settings.shared.fontName, size: 16))
            }
        }.listStyle(.plain)
    }
    
    private func title(_ type: FocusIntervalType) -> String {
        switch type {
        case .work: return "Work"
        case .shortRest: return "Short Rest"
        case .longRest: return "Long Rest"
        }
    }
}

#Preview {
    DailyTaskSummaryView(selectedDate: Date())
}
