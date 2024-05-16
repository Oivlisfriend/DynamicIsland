import WidgetKit
import SwiftUI
import ActivityKit

struct Tutorial_Widget: Widget {
   @State var timeDifference = 0 // Diferença de tempo em minutos
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeTrackingAttribute.self) { context in
            TimeTrackingWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    TimeTrackingWidgetView(context: context)
                    
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Started: \(timeDifference)").onReceive(timer) { _ in
                        timeDifference = Int(-TimeTrackingWidgetView(context: context).context.state.startTime.timeIntervalSinceNow) // Incrementa o contador a cada segundo
                    }
                }
                
            } compactLeading: {
                Text("CL")
            } compactTrailing: {
                Text("CT")
            } minimal: {
                Text("M")
            }
        }
    }
}

struct TimeTrackingWidgetView: View {
     let context: ActivityViewContext<TimeTrackingAttribute>
    
    var body: some View {
        Text("Time trackingcvcv started: \(context.state.startTime, style: .relative)") .font(.system(size: context.state.startTime.timeIntervalSince1970))
    }
 
}
 
