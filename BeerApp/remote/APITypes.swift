//
//  APITypes.swift
//  BeerApp
//
//  Created by Bram De coster on 30/12/2022.
//

import Foundation

extension API {
    
    enum Types {
        
        enum Response {
            struct BeerList: Decodable {
                var beerList: [Beer]
                
                struct Beer: Decodable {
                    var id: Int
                    var naam: String
                    var alcoholPercentage : Double
                    var brouwer : String
                    var soort : String
                    var beschrijving : String
                    var inhoud : Int
                    var favorite: Bool
                }
            }
           
        }
        
        enum Request {
            struct Empty: Encodable {}
        }
        
        enum Error: LocalizedError {
            case generic(reason: String)
            case `internal`(reason: String)
            
            var errorDescription: String? {
                switch self {
                case .generic(let reason):
                    return reason
                case .internal(let reason):
                    return "Internal error: \(reason)"
                }
            }
        }
        
        enum Endpoint {
            case getAll(query: String)
            case getById(id: Int)
            
            var url: URL {
                
                var components = URLComponents()
                components.host = "swiftapi-production.up.railway.app"
                components.scheme = "https"
                
                switch self {
                    case .getAll(let query):
                        components.path = "/api/beer/"
                    case .getById(let id):
                        components.path = "/api/beer/"
                        components.queryItems = [
                            URLQueryItem(name: "id", value: "\(id)")
                        ]
                }
                
                return components.url!
            }
        }
        
        enum Method : String {
            case get
            case post
        }
    }
}
