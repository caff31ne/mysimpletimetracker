//
//  FocusView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/17/25.
//

import SwiftData
import SwiftUI

struct FocusView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel = FocusViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .center) {
                
                Spacer()
                
                HStack(alignment: .center, spacing: 20) {
                    
                    Button("Short Break") {
                        viewModel.setActiveInterval(.shortRest)
                    }
                    .font(Font.custom(Settings.shared.fontName, size: viewModel.isShortRest ? 18 : 14))
                    .bold(viewModel.isShortRest)
                    .foregroundColor(viewModel.isShortRest ? Color.prominent : Color.primary)
                    
                    Button("Work") {
                        viewModel.setActiveInterval(.work)
                    }
                    .font(Font.custom(Settings.shared.fontName, size: viewModel.isWork ? 18 : 14))
                    .bold(viewModel.isWork)
                    .foregroundColor(viewModel.isWork ? Color.prominent : Color.primary)
                    
                    Button("Long Break") {
                        viewModel.setActiveInterval(.longRest)
                    }
                    .font(Font.custom(Settings.shared.fontName, size: viewModel.isLongRest ? 18 : 14))
                    .bold(viewModel.isLongRest)
                    .foregroundColor(viewModel.isLongRest ? Color.prominent : Color.primary)
                }
                
                Spacer()
                
                HStack (alignment: .center, spacing: 0) {
                    
                    if viewModel.timer.isStopped {
                        Button(action: {
                            viewModel.decreaseDuration()
                        }, label: {
                            VStack(alignment: .trailing) {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            .foregroundColor(Color.prominent)
                            .frame(width: 60, height: 60)
                        })
                    }

                    Text(viewModel.time)
                        .font(Font.custom("ProFont", size: 48))

                    if viewModel.timer.isStopped {
                        
                        Button(action: {
                            viewModel.increaseDuration()
                        }, label: {
                            VStack(alignment: .leading) {
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.prominent)
                        })
                    }
                }
                
                ProgressBarView(value: viewModel.progress)
                    .frame(height: 20)
                    .padding(.horizontal, 80)
                
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
                        .foregroundColor(Color.prominent)
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
                            .lineLimit(4)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(Font.custom(Settings.shared.fontName, size: 20))
                    } else {
                        Text("+ task")
                            .font(Font.custom(Settings.shared.fontName, size: 20))
                            .foregroundColor(Color.prominent)
                            .frame(minWidth: 50)
                            .frame(height: 50)
                    }
                })
                .frame(height: 50)
                
                Spacer()
            }
            .padding()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Focus")
                            .font(.custom("RussoOne-Regular", size: 24))
                            .bold()
                            .padding()
                    }
                }
            }
            .foregroundColor(Color.primary)
            .toolbarBackground(.visible, for: .navigationBar)
        }.onAppear {
            viewModel.activate(modelContext: modelContext)
        }
    }
}

#Preview {
    FocusView()
}
