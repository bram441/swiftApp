//
//  ContentView.swift
//  BeerApp
//
//  Created by Bram De coster on 17/11/2022.
//

import SwiftUI

struct HomeScreenView: View {
    
    @StateObject private var viewModel = HomeScreenViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.beers, id: \.id) { beer in
                        BeerView(beer: beer).listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
                    Button(action: viewModel.fetchBeers) {
                        Text("Retry")
                    }
                }
            }.navigationTitle("Beer of the month")
        }.onAppear(perform: viewModel.fetchBeers)
    }

}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
