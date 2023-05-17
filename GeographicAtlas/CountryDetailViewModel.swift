//
//  CountryDetailViewModel.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 13.05.2023.
//

import Foundation
import UIKit


class CountryDetailViewModel: ObservableObject, FetchableImage {
    @Published var countryDetail: CountryDetailModel?
    
    func fetchCountryDetailInfo(countryCode: String) {
        let countryUrl = "\(CountriesGatewayHelper.url)/alpha/\(countryCode)"
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
                               let countries = try? deocoder.decode([CountryDetailModel].self, from: data) {
                                // TODO: Handle setting the data
                                self?.countryDetail = countries[0]
                                self?.fetchImage(from: countries[0].flags.png, options: nil) { (flagData) in
                                    if let data = flagData {
                                        DispatchQueue.main.async {
                                            self?.countryDetail?.flagImage = UIImage(data: data)?.cgImage
                                        }
                                    }
                                }
                            } else {
                                // TODO: Handle error
                            }
                        }
                    }
                }
                .resume()
        }
    }
    
}
