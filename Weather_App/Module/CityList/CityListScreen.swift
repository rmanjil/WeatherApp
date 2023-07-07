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
    @State private var selectedCity: CityModel? = nil
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding()
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.filteredCityModels(searchText: searchText), id: \.id) { cityModel in
                        Button(action: {
                            showWeather(of: cityModel.name)
                        }) {
                            Text(cityModel.name).padding()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("City List")
    }
    
    private func showWeather(of city: String) {
        presentationMode.wrappedValue.dismiss()
        if let navController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController as? UINavigationController {
            navController.pushViewController(CurrentWeatherController(baseScreen: CurrentWeatherScreen(), baseViewModel: CurrentWeatherViewModel(cityName: city)), animated: true)
        }
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
