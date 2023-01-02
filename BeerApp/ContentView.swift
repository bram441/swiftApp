//
//  ContentView.swift
//  BeerApp
//
//  Created by Bram De coster on 09/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeScreenView()
                .tabItem {
                    Label("Home", systemImage: "person")
                }

            AddBeerView()
                .tabItem {
                    Label("Add", systemImage: "🍻")
                }

            BeerListView()
                .tabItem {
                    Label("Lists", systemImage: "book")
                }

            FavoriteBeerView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }

    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
