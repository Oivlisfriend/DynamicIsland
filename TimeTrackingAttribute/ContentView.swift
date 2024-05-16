//
//  ContentView.swift
//  TimeTrackingAttribute
//
//  Created by Dumilde on 13/05/24.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var isTrackingTime: Bool = false
    @State private var startTime: Date? = nil
    @State private var activity: Activity<TimeTrackingAttribute>? = nil

    var body: some View {
        NavigationView{
                VStack {
                    if let startTime {
                        Text("Started: \(startTime, style: .relative)")
                    }
                    
                    Button {
                                      
                           isTrackingTime.toggle()
                           if isTrackingTime {
                               startTime = .now
                               
                               let attributes = TimeTrackingAttribute()
                               let state = TimeTrackingAttribute.ContentState(startTime: .now)
                               let staleDate = Date().addingTimeInterval(60 * 60 * 24)
                               let content = ActivityContent(state: state, staleDate: staleDate)
                               activity = try? Activity<TimeTrackingAttribute>.request(attributes: attributes, content:content, pushType: nil)
                           } else {
                               guard let startTime else {return}
                               let state = TimeTrackingAttribute.ContentState(startTime: startTime)
                               Task{
                                   await activity?.end(using:state,dismissalPolicy:.immediate)
                               }
                               self.startTime = nil
                               
                           }
                       } label: {
                           Text(isTrackingTime ? "Stop Tracking" : "Start Tracking")
                              
                       }
                   
                }
                .padding()
            }
        }
}
#Preview {
    ContentView()
}
