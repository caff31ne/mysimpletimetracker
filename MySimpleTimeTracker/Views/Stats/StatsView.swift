//
//  StatsView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/17/25.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var records: [FocusInterval]
    
    private func title(_ type: FocusIntervalType) -> String {
        switch type {
        case .work: return "Work"
        case .shortRest: return "Short Rest"
        case .longRest: return "Long Rest"
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(records) {
                    Text(title($0.type))
                        .font(Font.custom(Settings.shared.fontName, size: 16))
                }
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Statistics")
                        .font(.custom("RussoOne-Regular", size: 24))
                        .bold()
                        .padding()
                        .foregroundColor(Color(white: 0.3))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    StatsView()
        .modelContainer(for: FocusInterval.self, inMemory: true)
}
