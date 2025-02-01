//
//  TaskCreateView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/28/25.
//

import SwiftUI

struct TaskCreateView: View {
    
    @FocusState var isNewTaskFocused: Bool
    @State var title = String()
    var onSubmit: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("New task", text: $title)
                .focused($isNewTaskFocused)
                .onSubmit {
                    onSubmit(title)
                    title = ""
                }
                .padding(.leading, 30)
        }
        .onAppear {
            isNewTaskFocused = true
        }
    }
}

#Preview {
    TaskCreateView(onSubmit: { _ in })
}
