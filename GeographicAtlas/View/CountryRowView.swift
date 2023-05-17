//
//  CountryRowView.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 13.05.2023.
//

import SwiftUI

struct CountryRowView: View {
    let country: CountryModel
    @StateObject var viewModel = CountryDetailViewModel()
    @State private var isExpanded = false
    
    var body: some View {
        NavigationStack {
            Group {
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        CountryMainInfo(country: country)
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }) {
                            Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: 24)
                        
                    }
                    
                    if isExpanded {
                        CountryRestInfo(country: country)
                            .padding(.top, 4)
                        Spacer()
                        
                        HStack() {
                            NavigationLink(destination: CountryDetailsView(country: country)) {
                                Text("Learn more")
                                    .font(.custom("SFProText-Semibold", size: 17))
                                    .foregroundColor(.blue)
                                    .padding(.horizontal)
                                
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                        
                    }
                    
                    Spacer()
                }
                .padding(.all, 12)
                
            }
            .font(.custom("SFProText-Semibold", size: 17))
            .background(Color(red: 0.969, green: 0.973, blue: 0.976))
            .cornerRadius(12)
        }
    }
}

struct CountryMainInfo: View {
    let country: CountryModel
    
    var body: some View {
        HStack(){
            getImage(for: country)
                .resizable()
                .frame(maxWidth: 82, maxHeight: 48)
                .cornerRadius(8)
            VStack(alignment: .listRowSeparatorLeading, spacing: 4) {
                Text(country.name.common)
                    .font(.custom("SFProText-Semibold", size: 17))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0))
                Text(country.capital)
                    .font(.custom("SFProText-Regular", size: 13))
                    .foregroundColor(Color(red: 0.533, green: 0.533, blue: 0.533))
                
            }
            .frame(maxWidth: 237, alignment: .leading)
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, maxHeight: 72)
    }
    
    func getImage(for country: CountryModel) -> Image {
        if let countryFlag = country.flagImage {
            return Image(countryFlag, scale: 1.0, label: Text(""))
        } else {
            return Image("Flag")
        }
    }
}

struct CountryRestInfo: View {
    let country: CountryModel
    var body: some View {
        HStack {
            Text("Population:")
            Text("\(country.population)")
                .foregroundColor(.black)
        }
        .font(.custom("SFProText-Regular", size: 15))
        .foregroundColor(Color(red: 0.533, green: 0.533, blue: 0.533))
        
        HStack {
            Text("Area:")
            Text("\(country.area)")
                .foregroundColor(.black)
        }
        .font(.custom("SFProText-Regular", size: 15))
        .foregroundColor(Color(red: 0.533, green: 0.533, blue: 0.533))
        
        HStack {
            Text("Currencies:")
            Text("\(country.currencyText)")
                .foregroundColor(.black)
        }
        .font(.custom("SFProText-Regular", size: 15))
        .foregroundColor(Color(red: 0.533, green: 0.533, blue: 0.533))
    }
}


struct CountriesListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let name = CountryModel.Name(common: "Kazakhstan")
        let currencies = CountryModel.CurrencyList(list: [
            CountryModel.Currency(name: "Tenge", symbol: "🇰🇿")
        ])
        let flags = CountryModel.Flags(png: "")
        let capitalsCoordinates = CountryModel.LatitudeLongtitude(latlng: [51.16, 71.45])
        
        CountryRowView(country: .init(
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
        .previewLayout(.fixed(width: 343, height: 216))
    }
}
