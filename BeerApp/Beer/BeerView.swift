//
//  BeerView.swift
//  BeerApp
//
//  Created by Bram De coster on 02/01/2023.
//

import SwiftUI

struct BeerView: View {
    
    @StateObject private var viewModel = BeerViewModel()
    let beer: Beer

    var body: some View {
   
        VStack(alignment: .leading) {
            Text("**Naam**: \(beer.naam)")
            Text("**AlcoholPercentage**: \(round(beer.alcoholpercentage * 10) / 10.0) %")
            Text("**Inhoud**: \(beer.inhoud) cl")
            Text("**Brouwer**: \(beer.brouwer)")
            Text("**Beschrijving**: \(beer.beschrijving)")
            Text("**Soort**: \(beer.soort)")
            if(beer.favoriet == 1) {
                Button("\(Image(systemName: "heart.fill"))", action: toggleFavorite).foregroundColor(.red)
            } else {
                Button("\(Image(systemName: "heart"))", action: toggleFavorite).foregroundColor(.red)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal,4)
    }
    
    func toggleFavorite() {
        viewModel.toggleFavorite(favorite: beer.favoriet, id: beer.id)
    }
}

struct BeerView_Previews: PreviewProvider {
    static var previews: some View {
        BeerView(beer: .init(id: 0, naam: "test", alcoholpercentage: 8, brouwer: "Test", soort: "Teset", beschrijving: "test", inhoud: 33, favoriet: 0))
    }
}
