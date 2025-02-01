//
//  Double+TimeFormat.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/22/25.
//

extension Double {
    
    func asFormattedTime(_ units: Bool = false, _ blink: Bool = true) -> String {
        let hours = Int(self) / 3600
        let remainingSecondsInHour = Int(self) % 3600
        let minutes = remainingSecondsInHour / 60
        let seconds = remainingSecondsInHour % 60
        let semicolon = blink && self.truncatingRemainder(dividingBy: 1) < 0.5 ? ":" : " "
        if units {
            return hours == 0
                ? String(format: "%02dm %02ds", minutes, seconds)
                : String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
        } else {
            return hours == 0
                ? String(format: "%02d\(semicolon)%02d", minutes, seconds)
                : String(format: "%02d\(semicolon)%02d\(semicolon)%02d", hours, minutes, seconds)
        }
    }
}
