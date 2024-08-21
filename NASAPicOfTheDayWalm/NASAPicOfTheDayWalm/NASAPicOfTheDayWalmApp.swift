//
//  NASAPicOfTheDayWalmApp.swift
//  NASAPicOfTheDayWalm
//
//  Created by Harish Sami on 21/08/24.
//

import SwiftUI

@main
struct NASAPicOfTheDayWalmApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
