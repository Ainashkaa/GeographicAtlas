//
//  CountryDetailsView.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 15.05.2023.
//

import SwiftUI

struct CountryDetailsView: View {
    
    let country: CountryModel
    
 
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 4) {
                Group {
                    Image("Flag")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 193)
                        .cornerRadius(8)
                    Description("Region")
                    CountryValues(country.name.common)
                    Description("Capital")
                    CountryValues(country.capital)
                    Description("Capital coordinates")
                    if let coordinates = country.capitalCoordinates,
                       let latitude = coordinates.latlng?.first,
                       let longtitude = coordinates.latlng?.last {
                        CountryValues("\(latitude)', \(longtitude)'")
                    }
                }
                Group {
                    Description("Population")
                    CountryValues("\(country.population) mln")
                    Description("Area")
                    CountryValues("\(String(country.area)) km")
                    Description("Currency")
                    if let currency = country.currencies,
                       let name = currency.list.first?.name,
                       let symbol = currency.list.first?.symbol {
                        CountryValues("\(name), \(symbol)")
                    }
                    Description("Timezones")
                    if let timezones = country.timezones.last {
                        CountryValues("\(timezones)")
                        
                    }
                }
            }
            .padding(.top, 20)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            Spacer()
                .navigationTitle(country.name.common)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text(country.name.common)
                                .fontWeight(.bold)
                                .font(.custom("SF Pro Text", size: 17))
                                .foregroundColor(.black)
                            Divider()
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Description: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack{
            Image(systemName: "circle.fill")
                .font(.custom("SFProText-Semibold", size: 8))
                .frame(width: 24, height: 10)
            
            Text(text)
                .font(.custom("SFProText-Regular", size: 15))
                .foregroundColor(Color(red: 0.533, green: 0.533, blue: 0.533))
        }
        .padding(.top, 20)
    }
}

struct CountryValues: View {
    var text: String?
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text ?? "")
            .font(.custom("SFProText-Regular", size: 20))
            .padding(.leading, 32)
    }
}

struct CountryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let name = CountryModel.Name(common: "Kazakhstan")
        let currencies = CountryModel.CurrencyList(list: [
            CountryModel.Currency(name: "Tenge", symbol: "₸"),
            CountryModel.Currency(name: "Indian rupi", symbol: "r")
        ])
        let flags = CountryModel.Flags(png: "")
        let capitalsCoordinates = CountryModel.LatitudeLongtitude(latlng: [51.16, 71.45])
        
        
        CountryDetailsView(country: .init(
            name: name,
            population: 19,
            area: 2.725,
            capitals: ["Astana"],
            countryCode2: "KZ",
            countryCode3: "KAZ",
            region: "Asia",
            timezones: ["UTC+05:00", "UTC+06:00"],
            flags: flags,
            continents: ["Asia"],
            capitalCoordinates: capitalsCoordinates,
            currencies: currencies)
        )
        
        
        
    }
}
