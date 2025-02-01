//
//  TaskSelectionView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/21/25.
//

import SwiftData
import SwiftUI

struct TaskSelectionView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \TaskAssignment.created) private var tasks: [TaskAssignment]
    
    @Binding var selectedTask: TaskAssignment?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .font(Font.custom(Settings.shared.fontName, size: 16))
                    .onTapGesture {
                        selectedTask = task
                        dismiss()
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Tasks")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(tasks[index])
            }
        }
    }
}

#Preview {
    TaskSelectionView(selectedTask: .constant(nil))
        .modelContainer(for: TaskAssignment.self, inMemory: true)
}
