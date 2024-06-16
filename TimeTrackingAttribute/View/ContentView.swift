//
//  ContentView.swift
//  TimeTrackingAttribute
//
//  Created by Dumilde on 13/05/24.
//

import SwiftUI
import ActivityKit
import WidgetKit


struct ContentView: View {
    @State private var isTrackingTime1: Bool = false
    @State private var startTime1: Date? = nil
    @State private var activity1: Activity<TimeTrackingAttribute>? = nil
    @ObservedObject var viewModel = ContentViewModel()
    @State private var isTrackingTime2: Bool = false
    @State private var startTime2: Date? = nil
    @State private var activity2: Activity<TimeTrackingAttribute>? = nil
    @State private var value = 0
    var body: some View {
        NavigationView {
            VStack {
                if let startTime1 = startTime1 {
                    Text("Timer 1 Started: \(startTime1, style: .relative)")
                }
                Button(action: {
                    toggleTracking(for: &isTrackingTime1, startTime: &startTime1, activity: &activity1)
                }) {
                    Text(isTrackingTime1 ? "Stop Timer 1" : "Start Timer 1")
                }
                Text("\(value)")
                if let startTime2 = startTime2 {
                    Text("Timer 2 Started: \(startTime2, style: .relative)")
                }
                Button(action: {
                    toggleTracking(for: &isTrackingTime2, startTime: &startTime2, activity: &activity2)
                }) {
                    Text(isTrackingTime2 ? "Stop Timer 2" : "Start Timer 2")
                }
                HStack{
                    Button(action: {
                        WidgetCenter.shared.reloadAllTimelines()

                        viewModel.updateValue()
                        value = UserDefaults.standard.integer(forKey: "sharedDataKey") // Acessar o valor atualizado de state
                    }){
                        Text("Start")
                    }
                }
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func toggleTracking(for trackingState: inout Bool, startTime: inout Date?, activity: inout Activity<TimeTrackingAttribute>?) {
        trackingState.toggle()
        if trackingState {
            let newStartTime = Date.now
            startTime = newStartTime  // Update the displayed start time
            startActivity(startTime: newStartTime, activity: &activity)
        } else {
            stopActivity(activity: &activity)
            startTime = nil
        }
    }
    
    func startActivity(startTime: Date, activity: inout Activity<TimeTrackingAttribute>?) {
        let attributes = TimeTrackingAttribute()
        let state = TimeTrackingAttribute.ContentState(startTime: startTime)
        let staleDate = Date().addingTimeInterval(60 * 60 * 24)  // 24 hours from now
        
        do {
            activity = try Activity<TimeTrackingAttribute>.request(attributes: attributes, content: ActivityContent(state: state, staleDate: staleDate), pushType: nil)
        } catch {
            print("Failed to start activity: \(error)")
        }
    }
    
    func stopActivity(activity: inout Activity<TimeTrackingAttribute>?) {
        if let existingActivity = activity {
            Task {
                await existingActivity.end(using: TimeTrackingAttribute.ContentState(startTime: existingActivity.contentState.startTime), dismissalPolicy: .immediate)
            }
            activity = nil
        }
    }
}

#Preview {
    ContentView()
}
