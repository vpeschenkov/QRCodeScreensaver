//
//  Preferences.swift
//  QRCode
//
//  Created by Victor Peschenkov on 6/10/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import QRCodeCore
import ScreenSaver

class QRCodePreferences: QRCodeCore.QRCodePreferences {
    static public let shared = QRCodePreferences()
    
    public let bundle = Bundle(for: QRCodePreferences.self)
    
    // MARK: - QRCodeCore.QRCodePreferences
    
    var message: String {
        set {
            defaults.set(newValue, forKey: Keys.message)
            defaults.synchronize()
        }
        get {
            return defaults.string(forKey: Keys.message) ?? ""
        }
    }
    
    // MARK: - Keys
    
    private enum Keys {
        static let message = "message-key"
    }
    
    fileprivate lazy var defaults: ScreenSaverDefaults = {
        guard let bundleIdentifier = bundle.bundleIdentifier, let defaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier) else {
            fatalError("Failed to retrieve settings")
        }
        defaults.register(defaults: [
            Keys.message: "What are you looking for? ;-)"
            ])
        return defaults
    }()
}
