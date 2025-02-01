//
//  TaskFilteredListView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/26/25.
//

import SwiftData
import SwiftUI

struct TaskFilteredListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var tasks: [TaskAssignment]

    @Bindable var viewModel: TasksViewModel
    
    init(viewModel: TasksViewModel) {
        self.viewModel = viewModel
        let showCompleted = viewModel.showCompleted
        _tasks = Query(filter: #Predicate { (task: TaskAssignment) -> Bool in showCompleted || !task.complete }, sort: \.created)
    }
    
    var body: some View {
        List {
            if viewModel.showFilters {
                Spacer()
                    .frame(height: 44)
            }
            ForEach(tasks) { task in
                if task == viewModel.editingTask {
                    TaskEditView(task: task) {
                        task.title = $0
                        viewModel.editingTask = nil
                    }
                } else {
                    TaskRow(task: task, showTime: viewModel.showTime, editingEnabled: !viewModel.isEditingActive) {
                        viewModel.editingTask = task
                    }
                }
            }
            .onDelete(perform: deleteItems)
            
            if viewModel.showAddNewTask {
                TaskCreateView() {
                    viewModel.addNewTask($0)
                }
            }
        }
        .listStyle(.plain)
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
    TaskFilteredListView(viewModel: TasksViewModel())
        .modelContainer(for: TaskAssignment.self, inMemory: true)
}
