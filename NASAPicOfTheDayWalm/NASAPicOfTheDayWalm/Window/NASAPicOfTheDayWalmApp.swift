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
    init() {
           setupNavigationBarAppearance()
       }

    var body: some Scene {
        WindowGroup {
            ApodView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    // Function to set up the navigation bar appearance
       private func setupNavigationBarAppearance() {
           let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = UIColor.white // Background color
           appearance.titleTextAttributes = [.foregroundColor: UIColor.purple] // Title text color
           appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.purple]

           UINavigationBar.appearance().standardAppearance = appearance
           UINavigationBar.appearance().scrollEdgeAppearance = appearance
           UINavigationBar.appearance().tintColor = .purple // Tint color for bar items
       }
}
