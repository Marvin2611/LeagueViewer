//
//  LeagueViewerApp.swift
//  LeagueViewer
//
//  Created by Student on 16.06.22.
//

import SwiftUI

@main
struct LeagueViewerApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        debugPrint("App init")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ContentViewModel())
        }
        .onChange(of: scenePhase) {
            switch $0 {
            case .active: debugPrint("App got active.")
            case .background: debugPrint("App went to background")
            case .inactive: debugPrint("App got inactive.")
            @unknown default:
                fatalError()
            }
        }
    }
}
