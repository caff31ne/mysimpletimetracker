//
//  TaskRow.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/21/25.
//

import SwiftData
import SwiftUI

struct TaskRow: View {
    
    var task: TaskAssignment
    
    var showTime: Bool
    var editingEnabled: Bool
    var onEdit: () -> Void
    
    var body: some View {

        HStack(alignment: .center) {
            Image(systemName: task.complete ? "checkmark.circle" : "circle")
                .frame(width: 40, height: 40)
                .padding(.vertical, 0)
                .onTapGesture {
                    withAnimation {
                        task.complete.toggle()
                    }
                }
            HStack {
                Text(task.title)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .contentShape(Rectangle())
            .onLongPressGesture {
                if editingEnabled {
                    onEdit()
                }
            }
            if showTime {
                Text((task.focusTime + task.stopwatchTime).asFormattedTime(true))
            }
            TaskFocusView(task: task)
                .frame(width: 64)
                .foregroundColor(Color.orange)

        }
        .font(Font.custom(Settings.shared.fontName, size: 16))
        .padding(.vertical, 0)
        .padding(.trailing, 8)
        .listRowInsets(EdgeInsets())
    }
}

#Preview {
    TaskRow(task: TaskAssignment(title: "Test", complete: true), showTime: true, editingEnabled: false, onEdit: {})
}
