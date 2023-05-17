//
//  CountryListView.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 12.05.2023.
//

import SwiftUI

struct CountryListView: View {
    
    @StateObject var vm = CountryListViewModel()
    
    func groupByContinent(_ countries: [CountryModel]) -> [(String, [CountryModel])] {
        let grouped = Dictionary(grouping: countries, by: { $0.continents.first ?? "" })
        
        return grouped.sorted(by: { $0.key < $1.key })
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12){
                
                List() {
                    ForEach(groupByContinent(vm.countries), id: \.0) { continent, countries in
                        
                        Section(header: Text(continent)
                            .foregroundColor(Color(red: 0.672, green: 0.702, blue: 0.732))
                            .font(.custom("SFProText-Bold", size: 15))
                            .bold()) {
                                ForEach(countries, id: \.countryCode3) { country in
                                    CountryRowView(country: country)
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
            .onAppear(perform: vm.fetchData)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
