//
//  TaskApp.swift
//  Task
//
//  Created by Prithvi Rao Ratti on 04/08/23.
//

import SwiftUI

@main
struct TaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
