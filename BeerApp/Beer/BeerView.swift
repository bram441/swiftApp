//
//  BeerView.swift
//  BeerApp
//
//  Created by Bram De coster on 02/01/2023.
//

import SwiftUI
import AlertToast

struct BeerView: View {
    
    @StateObject private var viewModel = BeerViewModel()
    @State private var succes = false
    let beer: Beer

    var body: some View {
   
        VStack(alignment: .leading) {
            Text("**Name**: \(beer.naam)")
            Text("**AlcoholPercentage**: \(String(format: "%.1f", beer.alcoholpercentage)) %")
            Text("**Contents**: \(beer.inhoud) cl")
            Text("**Brewer**: \(beer.brouwer)")
            Text("**Description**: \(beer.beschrijving)")
            Text("**Type**: \(beer.soort)")
            if(beer.favoriet == 1) {
                Button("\(Image(systemName: "heart.fill"))", action: toggleFavorite).foregroundColor(.red)
            } else {
                Button("\(Image(systemName: "heart"))", action: toggleFavorite).foregroundColor(.red)
            }
        }.toast(isPresenting: $succes) {
            AlertToast(type: .complete(.green), title: beer.favoriet == 1 ? "Removed from favorites" : "Added to favorites")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(hue: 1.0, saturation: 0.017, brightness: 0.686), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal,4)
    }
    
    func toggleFavorite() {
        succes = true
        viewModel.toggleFavorite(favorite: beer.favoriet, id: beer.id)
    }
}

struct BeerView_Previews: PreviewProvider {
    static var previews: some View {
        BeerView(beer: .init(id: 0, naam: "test", alcoholpercentage: 8, brouwer: "Test", soort: "Teset", beschrijving: "test", inhoud: 33, favoriet: 0))
    }
}
