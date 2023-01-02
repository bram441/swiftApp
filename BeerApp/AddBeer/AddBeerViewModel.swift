//
//  AddBier.swift
//  BeerApp
//
//  Created by Bram De coster on 08/12/2022.
//

import Foundation

class AddBeerViewModel : ObservableObject {
    
    @Published var beers: [Beer] = []
    @Published var hasError = false
    @Published var error: BeerError?
    
    func postBeer() {
        guard let url = URL(string: "https://swiftapi-production.up.railway.app/api/beer/addBeer") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                return
            }
        }
        dataTask.resume()
    }
}

extension AddBeerViewModel {
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
