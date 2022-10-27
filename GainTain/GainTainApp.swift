//
//  GainTainApp.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI

@main
struct GainTainApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
