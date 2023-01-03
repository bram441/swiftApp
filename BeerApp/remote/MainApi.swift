//
//  MainApi.swift
//  BeerApp
//
//  Created by Bram De coster on 03/01/2023.
//

import Foundation

class MainApi {
    
    @Published var hasError = false
    @Published var error: BeerError?
    var beers : [Beer] = []
    
    
    func toggleFavorite(favorite: Int, id: Int) {
        
        hasError = false
        
        var toggleFavoriteUrl = ""
        if(favorite == 1){
            toggleFavoriteUrl = "https://swiftapi-production.up.railway.app/api/beer/unFavorite/\(id)"
        } else {
            toggleFavoriteUrl = "https://swiftapi-production.up.railway.app/api/beer/setFavorite/\(id)"
        }
        
        guard let url = URL(string: toggleFavoriteUrl) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
                
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        self?.hasError = true
                        self?.error = BeerError.custom(error: error)
                    } else {
                      guard let response = response as? HTTPURLResponse,
                            (200...300)   ~= response.statusCode else {
                          self?.hasError = true
                          return
                      }
                    }
                }
            }
        dataTask.resume()
        }
    struct responseId : Codable{
        var id: Int
    }
}

extension MainApi {
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
