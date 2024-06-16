//
//  TimeTrackingAttributeApp.swift
//  TimeTrackingAttribute
//
//  Created by Dumilde on 13/05/24.
//

import SwiftUI

@main
struct TimeTrackingAttributeApp: App {
    var body: some Scene {
        WindowGroup {
            if let defaults = UserDefaults(suiteName: "group.TimeTrackingAttribute"){
                ContentView()
            }
            else{
                Text("Hello")
                }
        }
    }
}
