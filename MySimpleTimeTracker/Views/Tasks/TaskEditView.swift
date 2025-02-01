//
//  TaskEditView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/29/25.
//

import SwiftUI

struct TaskEditView: View {
  
    var task: TaskAssignment
    @FocusState var isEditFieldFocused: Bool
    @State private var title: String = ""
    
    var onSubmit: ((String) -> Void)
    
    var body: some View {
        HStack {
            TextField("New task", text: $title)
                .focused($isEditFieldFocused)
                .onSubmit {
                    onSubmit(title)
                }
                .padding(.leading, 30)
        }
        .onAppear {
            title = task.title
            isEditFieldFocused = true
        }
    }
}

#Preview {
    TaskEditView(task: TaskAssignment(title: "Test"), onSubmit: { _ in })
}
