//
//  Movie_Task_V2App.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import SwiftUI

@main
struct Movie_Task_V2App: App {
    @StateObject private var homeViewModel = HomeViewModel()
       @StateObject private var favoritesManager = FavoritesManager()

       var body: some Scene {
           WindowGroup {
               TabView {
                   HomeView()
                       .tabItem { Label("Home", systemImage: "house") }

                   FavoritesView()
                       .tabItem { Label("Favorites", systemImage: "heart.fill") }
               }
               .environmentObject(homeViewModel)
               .environmentObject(favoritesManager)
           }
       }
}
