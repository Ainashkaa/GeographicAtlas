//
//  CountryListViewModel.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 17.05.2023.
//

import Foundation
import SwiftUI

class CountryListViewModel: ObservableObject, FetchableImage {
    @Published var countries: [CountryModel] = []
    
    func fetchData() {
        let countryUrl = "\(CountriesGatewayHelper.url)/all"
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
                                // TODO: Handle setting the data
                                self?.countries = countries
                                self?.fetchFlags()
                            } else {
                                // TODO: Handle error
                            }
                        }
                    }
                }
                .resume()
        }
    }

    
    private func fetchFlags() {
        var allFlagsURLs = countries.map { $0.flags.png }

        fetchBatchImages(using: allFlagsURLs, options: nil, partialFetchHandler: { (imageData, index) in
            DispatchQueue.main.async {
                guard let data = imageData else { return }
                self.countries[index].flagImage = UIImage(data: data)?.cgImage
            }
        }) {
            print("Finished fetching flags")
        }
    }
}
