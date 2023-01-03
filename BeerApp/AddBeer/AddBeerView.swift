//
//  AddBeerView.swift
//  BeerApp
//
//  Created by Bram De coster on 08/12/2022.
//


import SwiftUI
import AlertToast

struct AddBeerView : View {
    
    @StateObject private var viewModel = AddBeerViewModel()
    @State private var succes = false
    @State private var failure = false
    
    var body: some View {
        NavigationView {
            Form {
                naam
                alcoholPercentage
                brouwer
                soort
                beschrijving
                inhoud
                
                Section {
                    submit
                }
            }
            .padding(.top)
            .navigationTitle("Can't find your beer?")
            .toast(isPresenting: $succes) {
                AlertToast(type: .complete(.green), title: "Beer added!")
            }
            .toast(isPresenting: $failure) {
                AlertToast(type: .error(.red), title: "All fields must be filled in!")
            }
        }
    }
}

private extension AddBeerView {
    var naam: some View {
        TextField("Name", text: $viewModel.beer.naam)
    }
    
    var alcoholPercentage: some View {
        TextField("Alcohol percentage", value: $viewModel.beer.alcoholpercentage, format: .number)
    }
    
    var brouwer: some View {
        TextField("Brewer", text: $viewModel.beer.brouwer)
    }
    
    var soort: some View {
        TextField("Type", text: $viewModel.beer.soort)
    }
    
    var beschrijving: some View {
        TextField("Description", text: $viewModel.beer.beschrijving)
    }
    
    var inhoud: some View {
        TextField("Contens", value: $viewModel.beer.inhoud, format: .number)
    }
    
    var submit: some View {
        Button("Submit") {
            if(viewModel.checkIfValues()) {
                viewModel.createBeer()
                succes.toggle()
            } else {
                failure.toggle()
            }

        }
    }
}

struct AddBeerView_Previews: PreviewProvider {
    static var previews: some View {
        AddBeerView()
    }
}
