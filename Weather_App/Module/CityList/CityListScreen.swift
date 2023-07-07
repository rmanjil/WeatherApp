//
//  CityListScreen.swift
//  Weather_App
//
//  Created by manjil on 07/07/2023.
//

import SwiftUI

struct CityListScreen: View {
    @ObservedObject var viewModel: CityListViewModel
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding()
            List {
                ForEach(viewModel.filteredCityModels(searchText: searchText), id: \.id) { cityModel in
                    Text(cityModel.name)
                }
            }
        }
        .navigationTitle("City List")
    }
}

struct CityListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CityListScreen(viewModel: CityListViewModel())
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(5)
            }
        }
    }
}
