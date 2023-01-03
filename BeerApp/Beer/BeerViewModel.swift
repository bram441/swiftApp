//
//  BeerViewModel.swift
//  BeerApp
//
//  Created by Bram De coster on 02/01/2023.
//

import Foundation

class BeerViewModel: ObservableObject {
    
    @Published var hasError = false
    
    func toggleFavorite(favorite: Int, id: Int) {
        MainApi().toggleFavorite(favorite: favorite, id: id)
    }
    
}
