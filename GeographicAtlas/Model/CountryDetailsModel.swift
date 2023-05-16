//
//  CountryDetailsModel.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 13.05.2023.
//

import Foundation

struct CountryDetailsModel: Codable {
    let name: Name
    let region: String
    let capital: String
    let capitalCoordinates: CapitalInfo
    let population: Int
    let area: Int
    let currency: Currency
    let flag: String
    let timezones: [String]
    let continents: String
    
    struct Currency: Codable {
        let name: String
        let symbol: String
    }
    
    struct Name: Codable {
        let common: String
    }
    
    struct CapitalInfo: Codable {
        let latitude: Double
        let longtitude: Double
        
    }
    
}

