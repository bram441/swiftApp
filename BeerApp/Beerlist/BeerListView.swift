//
//  BeerListView.swift
//  BeerApp
//
//  Created by Bram De coster on 08/12/2022.
//


import SwiftUI

struct BeerListView : View {
    
    @State private var searchText = ""
    @StateObject private var viewModel = BeerListViewModel()
    
    var body: some View {
        NavigationView {
                ZStack {
                    if(filterBeers.isEmpty) {
                        Text("Find Beers here!")
                    } else {
                        List {
                            ForEach(filterBeers, id: \.id) { beer in
                                BeerView(beer: beer).listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(.plain)
                        .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
                            Button(action: viewModel.fetchBeers) {
                                Text("Retry")
                            }
                        }
                    }
                }.onAppear(perform: viewModel.fetchBeers)
            }.searchable(text: $searchText)
            .navigationTitle("Find beers").font(.system(size: 20))
        }
    
    var filterBeers : [Beer] {
        let result : [Beer] = viewModel.filterBeers(searchText : searchText)
        if(!result.isEmpty) {
            return result
        }
        return []
    }
}



struct BeerListView_Previews: PreviewProvider {
    static var previews: some View {
        BeerListView()
    }
}
