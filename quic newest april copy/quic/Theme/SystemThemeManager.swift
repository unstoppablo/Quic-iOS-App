//
//  SystemThemeManager.swift
//  quic
//
//  Created by Pablo Labbate on 4/16/22.
//

import Foundation
import UIKit

class SystemThemeManager {
    
    static let shared = SystemThemeManager() // making the class into a singleton
    
    private init() {}
    
    func handleTheme(darkMode: Bool, system: Bool) {
        guard !system else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
            return
        }
        
        // will need to update eventually to non deprecated way
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
        
    }
}
