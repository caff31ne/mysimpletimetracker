//
//  TasksView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/19/25.
//

import SwiftData
import SwiftUI

struct TasksView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var viewModel = TasksViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                TaskFilteredListView(
                    viewModel: viewModel)

                if viewModel.showFilters {
                    HStack {
                        Toggle("Completed", isOn: $viewModel.showCompleted)
                            .toggleStyle(ButtonToggleStyle())
                        Toggle("Time", isOn: $viewModel.showTime)
                            .toggleStyle(ButtonToggleStyle())
                        Spacer()
                    }
                    .padding()
                    .background(Color(white: 0.95).opacity(0.95))
                }
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Tasks")
                        .font(.custom("RussoOne-Regular", size: 24))
                        .bold()
                        .padding()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation(.linear) {
                            viewModel.showFilters.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .foregroundColor(Color.prominent)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                        .foregroundColor(Color.prominent)
                }
                ToolbarItem {
                    Button {
                        viewModel.showAddNewTask = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.prominent)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .foregroundColor(Color.primary)
        }
        .onAppear {
            viewModel.modelContext = modelContext
        }
    }
}

#Preview {
    TasksView()
        .modelContainer(for: TaskAssignment.self, inMemory: true)
}
