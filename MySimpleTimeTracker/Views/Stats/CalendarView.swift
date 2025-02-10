//
//  CalendarView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 2/10/25.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {
    
    typealias UIViewType = UICalendarView
    
    @Binding var selectedDate: Date
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale.current
        calendarView.fontDesign = .rounded
        
        calendarView.delegate = context.coordinator
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        
        return calendarView
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        
        private var parent: CalendarView
        
        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            return nil
        }
        
        func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
            
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let dateComponents = dateComponents else { return }
            parent.selectedDate = Calendar.current.date(from: dateComponents) ?? Date()
        }
    }
    
}

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
