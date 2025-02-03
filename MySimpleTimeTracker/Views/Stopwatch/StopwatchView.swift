//
//  StopwatchView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/17/25.
//

import SwiftUI

struct StopwatchView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel = StopwatchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                Spacer()
                
                Text("Work")
                    .font(Font.custom(Settings.shared.fontName, size: 18))
                
                Spacer()
                
                Text(viewModel.time)
                    .font(Font.custom("ProFont", size: 48))
                
                Color.clear
                    .frame(height: 20)
                                
                HStack {
                    if viewModel.timer.isPaused {
                        Button {
                            viewModel.timer.stop()
                        } label: {
                            VStack(alignment: .center) {
                                Spacer()
                                Color.clear
                                    .frame(height: 10)
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Cancel")
                                    .font(.custom(Settings.shared.fontName, size: 10.0))
                                    .frame(height: 10)
                                Spacer()
                            }
                            .frame(width: 100, height: 100)
                        }
                    }
                    Button {
                        viewModel.timer.toggle()
                    } label: {
                        ZStack(alignment: .center) {
                            Image(systemName: viewModel.timer.isRunning ? "pause.fill" : "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                        .frame(width: 100, height: 100)
                    }
                    if viewModel.timer.isPaused {
                        Button {
                            viewModel.done()
                        } label: {
                            VStack(alignment: .center) {
                                Spacer()
                                Color.clear
                                    .frame(height: 10)
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                Text("Done")
                                    .font(.custom(Settings.shared.fontName, size: 10.0))
                                    .frame(height: 10)
                                Spacer()
                            }
                            .frame(width: 100, height: 100)
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: {
                    TaskSelectionView(selectedTask: $viewModel.task)
                }, label: {
                    if let title = viewModel.task?.title {
                        Text(title)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(Font.custom(Settings.shared.fontName, size: 20))
                    } else {
                        Text("+ task")
                            .font(Font.custom(Settings.shared.fontName, size: 20))
                            .frame(minWidth: 50)
                            .frame(height: 50)
                            .foregroundColor(Color.prominent)
                    }
                })
                .frame(height: 50)
                
                Spacer()
            }
            .padding()
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Stopwatch")
                        .font(.custom("RussoOne-Regular", size: 24))
                        .bold()
                        .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .foregroundColor(Color.primary)
        }.onAppear {
            viewModel.activate(modelContext: modelContext)
        }
    }
}

#Preview {
    StopwatchView()
}
