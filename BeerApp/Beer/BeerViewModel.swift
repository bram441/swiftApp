//
//  BeerViewModel.swift
//  BeerApp
//
//  Created by Bram De coster on 02/01/2023.
//

import Foundation

class BeerViewModel: ObservableObject {
    
    @Published var beers: [Beer] = []
    @Published var hasError = false
    @Published var error: BeerError?
    
    func toggleFavorite(favorite: Int, id: Int) {
        
        hasError = false
        
        var toggleFavoriteUrl = ""
        if(favorite == 1){
            toggleFavoriteUrl = "https://swiftapi-production.up.railway.app/api/beer/unFavorite/\(id)"
        } else {
            toggleFavoriteUrl = "https://swiftapi-production.up.railway.app/api/beer/setFavorite/\(id)"
        }
        
        if let url = URL(string: toggleFavoriteUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        self?.hasError = true
                        self?.error = BeerError.custom(error: error)
                        print(error)
                    } else {
                       let decoder = JSONDecoder()
                        
                        if let data = data {
                            do {
                                let id = try decoder.decode(responseId.self, from:data)
                                print(id)
                            } catch(let error) {
                                self?.hasError = true
                                self?.error = BeerError.failedToDecode
                                print(error)
                            }
                        }
                    }
                }
            }.resume()
        }
    }
    struct responseId : Codable{
        var id: Int
    }
}

extension BeerViewModel {
    enum BeerError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}

