//
//  Beer.swift
//  BeerApp
//
//  Created by Bram De coster on 02/01/2023.
//

import Foundation


struct Beer : Codable{
    var id: Int
    var naam: String
    var alcoholpercentage : Double
    var brouwer : String
    var soort : String
    var beschrijving : String
    var inhoud : Int
    var favoriet : Int
}

struct NewBeer: Codable {
    var naam: String
    var alcoholpercentage : Double
    var brouwer : String
    var soort : String
    var beschrijving : String
    var inhoud : Int
}
