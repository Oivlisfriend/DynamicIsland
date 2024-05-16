//
//  TimeTrackingAttribute.swift
//  TimeTrackingAttribute
//
//  Created by Dumilde on 14/05/24.
//
import Foundation
import ActivityKit

struct TimeTrackingAttribute : ActivityAttributes{
    public typealias TimeTrackingStatus = ContentState
    public struct ContentState: Codable, Hashable {
        var startTime: Date
        
    }

}
