//
//  HomeScreenViewModel.swift
//  BeerApp
//
//  Created by Bram De coster on 30/12/2022.
//

import Foundation


class HomeScreenViewModel : ObservableObject {
    
    @Published var hasError = false
    @Published var error: BeerError?
    @Published var randomBeer: Beer?
    @Published var succes = false
    
    func getRandomBeer() {
        
        hasError = false
        
        let getRandoBeerUrl = "https://swiftapi-production.up.railway.app/api/beer/random"
        if let url = URL(string: getRandoBeerUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        self?.hasError = true
                        self?.error = BeerError.custom(error: error)
                        self?.succes = false
                    } else {
                        let decoder = JSONDecoder()
                        
                        if let data = data {
                            do {
                                let randomBeer = try decoder.decode([Beer].self, from:data)
                                self?.randomBeer = randomBeer[0]
                                self?.succes = true
                            } catch(let error) {
                                self?.hasError = true
                                self?.error = BeerError.failedToDecode
                                self?.succes = false
                                print(error)
                            }
                        }
                    }
                }
            }.resume()
        }
    }
}

extension HomeScreenViewModel {
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
