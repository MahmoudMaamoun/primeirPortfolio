//
//  PrimerPortfolioApp.swift
//  PrimerPortfolio
//
//  Created by Mahmoud Maamoun on 29/03/2024.
//

import SwiftUI

@main
struct PrimerPortfolioApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController) 
        }
    }
}
