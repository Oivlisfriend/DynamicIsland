//
//  ContentViewModel.swift
//  TimeTrackingAttribute
//
//  Created by Dumilde on 22/05/24.
//

import SwiftUI
import WidgetKit

class ContentViewModel: ObservableObject {
    @Published var state: Int = 0
    
    func updateValue(){
        self.state += 1
        
        UserDefaults.standard.set(self.state, forKey: "sharedDataKey")
        UserDefaults.standard.synchronize()  // Garanta que o dado foi salvo

            // Solicitar ao WidgetKit para atualizar todos os widgets
        WidgetCenter.shared.reloadAllTimelines()
    }
}
