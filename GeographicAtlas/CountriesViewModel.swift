//
//  CountriesViewModel.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 13.05.2023.
//

import Foundation
import UIKit

class CountriesViewModel: ObservableObject {
    @Published var countries: [CountryModel] = []
    @Published var continents: [(String, [CountryModel])] = []
   
    
    
    func fetchData() {
        let countryUrl = "https://restcountries.com/v3.1/all"
        if let url = URL(string: countryUrl) {
            
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        // TODO: Handle returning data om the Main thread
                        if let error = error {
                            // TODO: Handle error
                        } else {
                            let deocoder = JSONDecoder()
                            deocoder.keyDecodingStrategy = .convertFromSnakeCase
                            if let data = data,
                               let countries = try? deocoder.decode([CountryModel].self, from: data) {
                                print(countries)
                                // TODO: Handle setting the data
                                self?.countries = countries
                                self?.groupCountriesByContinent()
                            } else {
                                // TODO: Handle error
                            }
                        }
                    }
                }
                .resume()
        }
    }
    
    private func groupCountriesByContinent() {
         let groupedContinents = Dictionary(grouping: countries, by: { $0.continents.first ?? "" })
         continents = groupedContinents.map { continent, countries in
             return (continent, countries)
         }
     }
    
    func fetchCountryDetailInfo(countryCode: String) {
        let countryUrl = "https://restcountries.com/v3.1/alpha/\(countryCode)"
        if let url = URL(string: countryUrl) {
            
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        // TODO: Handle returning data om the Main thread
                        if let error = error {
                            // TODO: Handle error
                        } else {
                            let deocoder = JSONDecoder()
                            deocoder.keyDecodingStrategy = .convertFromSnakeCase
                            if let data = data,
                               let countries = try? deocoder.decode([CountryModel].self, from: data) {
                                print(countries)
                                // TODO: Handle setting the data
                                self?.countries = countries
                            } else {
                                // TODO: Handle error
                            }
                        }
                    }
                }
                .resume()
        }
    }
    
//    func fetchImage(from url: String) -> UIImage? {
//        guard let url = URL(string: url) else {
//            print("Unable to create URL")
//            return nil
//        }
//        var image: UIImage?
//        DispatchQueue.main.async {
//            do {
//                //3. Get valid data
//                let data = try Data(contentsOf: url, options: [])
//                //4. Make image
//                image = UIImage(data: data)
//                
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//        }
//        return image!
//        
//    }

}
