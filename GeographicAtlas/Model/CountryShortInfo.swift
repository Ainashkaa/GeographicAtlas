//
//  CountryShortInfo.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 14.05.2023.
//

import Foundation

struct CountryShortInfo: Codable {
    let name: Name
    
    let population: Int
    let area: Double
    let capitals: [String]?
    let countryCode2: String
    let countryCode3: String
    let currencies: Currency?
    let region: String
    let timezones: [String]
    let flags: Flags
    let continents: [String]
    let capitalCoordinates: LatitudeLongtitude?
    
    
    
    struct Name: Codable {
        let common: String
    }
    
    struct Flags: Codable {
        let png: String
    }
    
    struct Currency: Codable {
        let name: String?
        let symbol: String?
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<CountryShortInfo.Currency.CodingKeys> = try decoder.container(keyedBy: CountryShortInfo.Currency.CodingKeys.self)
            self.name = try container.decode(String.self, forKey: CountryShortInfo.Currency.CodingKeys.name)
            self.symbol = try container.decode(String.self, forKey: CountryShortInfo.Currency.CodingKeys.symbol)
        }
    }
    
    struct LatitudeLongtitude: Codable {
        var latlng: [Double]?
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<CountryShortInfo.LatitudeLongtitude.CodingKeys> = try decoder.container(keyedBy: CountryShortInfo.LatitudeLongtitude.CodingKeys.self)
            self.latlng = try container.decodeIfPresent([Double].self, forKey: CountryShortInfo.LatitudeLongtitude.CodingKeys.latlng)
        }
    }
    
    enum SimpleCodingKeys: String, CodingKey {
        case name, area, population, region, timezones, flags, continents, currencies
        case capitals = "capital"
        case countryCode2 = "cca2"
        case countryCode3 = "cca3"
        case capitalCoordinates = "capitalInfo"
        
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: SimpleCodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        capitals = try values.decodeIfPresent([String].self, forKey: .capitals) ?? []
        area = try values.decode(Double.self, forKey: .area)
        population = try values.decode(Int.self, forKey: .population)
        countryCode2 = try values.decode(String.self, forKey: .countryCode2)
        countryCode3 = try values.decode(String.self, forKey: .countryCode3)
        region = try values.decode(String.self, forKey: .region)
        timezones = try values.decode([String].self, forKey: .timezones)
        flags = try values.decode(Flags.self, forKey: .flags)
        continents = try values.decode([String].self, forKey: .continents)
        capitalCoordinates = try values.decodeIfPresent(LatitudeLongtitude.self, forKey: .capitalCoordinates)
        currencies = try values.decodeIfPresent(Currency.self, forKey: .currencies)
    }
    
    
    
    
   
}
