//
//  AddBier.swift
//  BeerApp
//
//  Created by Bram De coster on 08/12/2022.
//

import Foundation

class AddBeerViewModel : ObservableObject {
    
    @Published var beer = NewBeer()
    @Published var hasError = false
    @Published var error: BeerError?
    @Published private(set) var state: SubmissionState?
    
    func checkIfValues() -> Bool{
        if(beer.naam == "" || beer.inhoud == 0 || beer.beschrijving == "" || beer.soort == "" || beer.brouwer == "") {
            return false
        }
        return true
    }
    
    func createBeer() {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(beer)
        postBeer(data: data)
    }
    
    func postBeer(data: Data?) {
        hasError = false
        guard let url = URL(string: "https://swiftapi-production.up.railway.app/api/beer/addBeer") else {
            return
        }
        
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    if error == nil {
                        self?.hasError = true
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse,
                          (200...300) ~= response.statusCode else {
                        self?.state = .fail
                        self?.hasError = true
                        return
                    }
                }
            }
            self.state = .succes
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

extension AddBeerViewModel {
    enum SubmissionState {
        case fail
        case succes
    }
}
