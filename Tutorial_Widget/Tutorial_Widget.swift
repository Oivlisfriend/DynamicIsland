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
                    VStack(alignment:.leading, spacing: 8){
                        Image("Backgroundroadr")
                            .frame(height: 20)
                            .padding(.top, 5)
                        Text("Dispatched")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        Text("ETA 15 min")
                            .font(.system(size: 14))
                            .fontWeight(.light)
                            .foregroundStyle(.gray)
                    }
                    .frame(width: 100)
                    .padding(.leading,-10)

                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment:.trailing, spacing: 8){
                        Image("Leadingside")
                        Text("Harrison Ford")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        Text("Ford F350")
                            .font(.system(size: 14))
                            .fontWeight(.light)
                            .foregroundStyle(.gray)
                    }.frame(width: 120)

                }
                DynamicIslandExpandedRegion(.bottom) {
                   // DynamicgWidgetView(context: context)  .padding(.leading, -25)
                    DynamicgWidgetDisptchedView(context: context)
               
                
                }
                
            } compactLeading: {
                Image("Roadr")
            } compactTrailing: {
                TimeTrackingWidgetView(context: context)
            } minimal: {
                Text("M")
            }
        }
    }
}

struct TimeTrackingWidgetView: View {
     let context: ActivityViewContext<TimeTrackingAttribute>
    
    var body: some View {
        Text(" \(context.state.startTime, style: .relative)").frame(width: 54).contentMargins(.leading,20)
    }
 
}
 
struct DynamicgWidgetView: View {
     let context: ActivityViewContext<TimeTrackingAttribute>
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Finding a specialist").font(.system(size: 16)).fontWeight(.semibold)
            Text("Stay safe, your wellbeing is our priority").font(.system(size: 14)).fontWeight(.light).foregroundStyle(.gray)
            HStack(){
                VStack{}
                    .padding(.vertical, 2)
                    .padding(.horizontal, 47)
                    .background(Color.blue)
                VStack{}
                    .padding(.vertical, 2)
                    .padding(.horizontal, 47)
                    .background(Color.blue)
                VStack{}
                    .padding(.vertical, 2)
                    .padding(.horizontal, 47)
                    .background(Color.blue)
            }
        }.padding(.top, 10)
    }
 
}
 
struct DynamicgWidgetDisptchedView: View {
    let context: ActivityViewContext<TimeTrackingAttribute>
    @State private var currentTime = false
    @State private var minutesSinceStart: Int = -1
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // Dispara a cada minuto

    var body: some View {
        
        let currentState = UserDefaults.standard.integer(forKey: "sharedDataKey") // Acessar o valor atualizado de state
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                timeBasedBackground(minuteComparison: 1, currentState: currentState)
                timeBasedBackground(minuteComparison: 2, currentState: currentState)
                timeBasedBackground(minuteComparison: 3, currentState: currentState)
            }
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: "star")
                Text("Rate \(currentState)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 40)
        .onReceive(timer) { _ in
            updateMinutesSinceStart()
        }
    }

    func updateMinutesSinceStart() {
        currentTime.toggle()
    }

    func timeBasedBackground(minuteComparison: Int, currentState: Int) -> some View {
        return VStack {}
            .padding(.vertical, 2)
            .padding(.horizontal, 53)
            .background(currentState >= minuteComparison ? Color.gray : Color.orange)
    }
}

