//
//  FocusConfig.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/24/25.
//

import Foundation

final class Settings: Codable {
    
    var fontName = "SpaceMono-Regular"
    
    var workDuration: TimeInterval = 25 * 60
    var shortRestDuation: TimeInterval = 5 * 60
    var longRestDuration: TimeInterval = 15 * 60
    
    var focusTaskId: UUID? {
        didSet {
            if focusTaskId != oldValue {
                save()
            }
        }
    }
    
    var stopwatchTaskId: UUID? {
        didSet {
            if focusTaskId != oldValue {
                save()
            }
        }
    }
    
    static var shared: Settings = {
        return load() ?? Settings()
    }()
    
    func duration(_ activeIntervalType: FocusIntervalType) -> TimeInterval {
        switch activeIntervalType {
        case .work:
            return Settings.shared.workDuration
        case .shortRest:
            return Settings.shared.shortRestDuation
        case .longRest:
            return Settings.shared.longRestDuration
        }
    }
    
    static func load() -> Settings? {
        guard let targetFilePath = settingsFilePath() else { return nil }
        
        do {
            let data = try Data(contentsOf: targetFilePath)
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            print("Can't load settings: \(error)")
            return nil
        }
    }
    
    func save() {
        guard let targetFilePath = Self.settingsFilePath() else { return }
        
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: targetFilePath)
        } catch {
            print("Can't save settings: \(error)")
        }
    }
    
    private static func settingsFilePath() -> URL? {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first?
            .appending(path: "settings.json", directoryHint: .notDirectory)
    }
}
