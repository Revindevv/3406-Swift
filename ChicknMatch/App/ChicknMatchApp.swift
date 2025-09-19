//
//  ChicknMatchApp.swift
//  ChicknMatch
//
//  Created by Serhii Babchuk on 12.09.2025.
//

import SwiftUI

@main
struct ChicknMatchApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppEntryPoint()
        }
    }
}
