//
//  ContentView.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 12.05.2023.
//

import SwiftUI

struct CountryView: View {
    
    @StateObject var viewModel = CountriesViewModel()
    @State var continents: [(String, [CountryModel])] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12){
                List() {
                    ForEach(viewModel.continents, id: \.0) { continent, countries in
                        Section(header: Text(continent)
                            .foregroundColor(Color(red: 0.672, green: 0.702, blue: 0.732))
                            .font(.custom("SFProText-Bold", size: 15))
                            .bold()){
                            ForEach(countries, id: \.countryCode3) { country in
                                CountriesListView(country: country)
                                    .listRowSeparator(.hidden)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("World countries")
                                .fontWeight(.bold)
                                .font(.custom("SF Pro Text", size: 17))
                                .foregroundColor(.black)
                            Divider()
                        }
                    }
                }
            }
            .onAppear(perform: viewModel.fetchData)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
    }
}
