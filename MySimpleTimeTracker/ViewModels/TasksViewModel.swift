//
//  TasksViewModel.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/28/25.
//

import SwiftData
import SwiftUI

@MainActor
@Observable
final class TasksViewModel {
    
    var modelContext: ModelContext?
    
    var showTime: Bool = true
    var showCompleted: Bool = true
    var showFilters: Bool = false
    var showAddNewTask: Bool = false
    
    var editingTask: TaskAssignment?
    var isEditingActive: Bool {
        editingTask != nil || showAddNewTask
    }
    
    func updateTask(_ task: TaskAssignment, title: String) {
        task.title = title
    }
    
    func addNewTask(_ title: String) {
        showAddNewTask = false
        if !title.isEmpty {
            modelContext?.insert(TaskAssignment(title: title, complete: false))
        }
    }
}
