//
//  TaskFocusView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/26/25.
//

import SwiftUI

struct TaskFocusView: View {
    
    let task: TaskAssignment
    
    var body: some View {
        if task.focusCount > 3 {
            HStack(spacing: 3) {
                Spacer()
                Text(String(task.focusCount))
                Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    .frame(width: 16, height: 16)
            }
        } else {
            HStack(spacing: 3) {
                Spacer()
                ForEach(0 ..< task.focusCount, id: \.self) { _ in
                    Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                        .frame(width: 16, height: 16)
                }
            }
        }
    }
}

#Preview {
    TaskFocusView(task: TaskAssignment(title: "Test"))
}
