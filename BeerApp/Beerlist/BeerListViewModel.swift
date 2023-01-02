//
//  BeerList.swift
//  BeerApp
//
//  Created by Bram De coster on 08/12/2022.
//

import Foundation

class BeerListViewModel : ObservableObject {
    
    @Published var beers: [Beer] = []
    @Published var hasError = false
    @Published var error: BeerError?
    
    func fetchBeers() {
        
        hasError = false
        
        let getAllBeersUrl = "https://swiftapi-production.up.railway.app/api/beer"
        if let url = URL(string: getAllBeersUrl) {
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
                                let beers = try decoder.decode([Beer].self, from:data)
                                self?.beers = beers
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
    
    func filterBeers(searchText: String) -> [Beer] {
        var resultList : [Beer] = []
        for beer in beers {
           // if searchText.lowercased().localizedStandardContains(beer.naam.lowercased()) {
             //   resultList.append(beer)
            //}
            if(beer.naam.localizedStandardContains(searchText.lowercased())) {
                resultList.append(beer)
            }
        }
        return resultList
    }
}

extension BeerListViewModel {
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
