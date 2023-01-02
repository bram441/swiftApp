//
//  FavoriteBeerView.swift
//  BeerApp
//
//  Created by Bram De coster on 08/12/2022.
//


import SwiftUI

struct FavoriteBeerView : View {
    
    @StateObject private var viewModel = FavoriteBeerViewModel()
    
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

struct FavoriteBeerView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteBeerView()
    }
}
