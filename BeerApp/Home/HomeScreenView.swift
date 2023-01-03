//
//  ContentView.swift
//  BeerApp
//
//  Created by Bram De coster on 17/11/2022.
//

import SwiftUI
import AlertToast

struct HomeScreenView: View {
    
    @StateObject private var viewModel = HomeScreenViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Button("Decide your next beer!", action: viewModel.getRandomBeer).frame(width: 493.0).foregroundColor(.blue).padding([.top, .leading, .trailing], 80)
                    .bold()
                    .font(.system(size: 35))
                    
                if(viewModel.randomBeer != nil) {
                    Text("You next beer is here for you! Cheers").bold().font(.headline).padding(.vertical, 20.0)
                    BeerView(beer: viewModel.randomBeer!)
                }
                Spacer()
            }.navigationTitle("Welcome!")
        }.toast(isPresenting: $viewModel.succes) {
            AlertToast(type: .regular, title: "Cheers!🍻")
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
