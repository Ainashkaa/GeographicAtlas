//
//  CountryModel.swift
//  GeographicAtlas
//
//  Created by Ainash Turbayeva on 13.05.2023.
//

import Foundation

struct CountryModel: Codable {
    let name: Name
    
    let population: Int
    let area: Double
    let capitals: [String]
    var capital: String
    let countryCode2: String
    let countryCode3: String
    let currencies: CurrencyList?
    let region: String
    let timezones: [String]
    let flags: Flags
    let continents: [String]
    let capitalCoordinates: LatitudeLongtitude?
    var currencyText: String
//    let currencyName: String
//    let currencySymbol: String
    
    
    struct Name: Codable {
        let common: String
    }
    
    struct Flags: Codable {
        let png: String
    }
    
    struct CurrencyList: Codable {
        var list: [Currency]

        private struct DynamicCodingKeys: CodingKey {

            // Use for string-keyed dictionary
            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }

            // Use for integer-keyed dictionary
            var intValue: Int?
            init?(intValue: Int) {
                // We are not using this, thus just return nil
                return nil
            }
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
            var tempArray = [Currency]()

            for key in container.allKeys {
                // Decode Student using key & keep decoded Student object in tempArray
                let decodedObject = try container.decodeIfPresent(Currency.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                if decodedObject != nil {
                    tempArray.append(decodedObject!)
                }
            }

            list = tempArray
        }
        
        init(list: [Currency]) {
            self.list = list
        }
    }
    
    struct Currency: Codable {
        let name: String?
        let symbol: String?
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<CountryModel.Currency.CodingKeys> = try decoder.container(keyedBy: CountryModel.Currency.CodingKeys.self)
            self.name = try container.decodeIfPresent(String.self, forKey: CountryModel.Currency.CodingKeys.name)
            self.symbol = try container.decodeIfPresent(String.self, forKey: CountryModel.Currency.CodingKeys.symbol)
        }
        
        init(name: String, symbol: String) {
            self.name = name
            self.symbol = symbol
        }
    }
    
    
    
    struct LatitudeLongtitude: Codable {
        var latlng: [Double]?
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<CountryModel.LatitudeLongtitude.CodingKeys> = try decoder.container(keyedBy: CountryModel.LatitudeLongtitude.CodingKeys.self)
            self.latlng = try container.decodeIfPresent([Double].self, forKey: CountryModel.LatitudeLongtitude.CodingKeys.latlng)
        }
        
        init(latlng: [Double]) {
            self.latlng = latlng
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
        currencies = try values.decodeIfPresent(CurrencyList.self, forKey: .currencies)
        
        currencyText = ""
        if currencies != nil {
            var c: [String] = []
            for i in 0..<currencies!.list.count {
                let currency = currencies!.list[i]
                let name = currency.name ?? ""
                let symbol = currency.symbol ?? ""
                
                c.append("\(name)(\(symbol))")
            }
            
            currencyText = c.joined(separator: ", ")
        }
        
        capital = ""
        if capitals.count > 0 {
            capital = capitals[0]
        }
        
//        currencyName = currencies.name
//        currencySymbol = currencies.symbol
    }
    
    init(name: Name, population: Int, area: Double, capitals: [String], countryCode2: String, countryCode3: String, region: String, timezones: [String], flags: Flags, continents: [String], capitalCoordinates: LatitudeLongtitude?, currencies: CurrencyList) {
        self.name = name
        self.population = population
        self.area = area
        self.capitals = capitals
        self.capital = capitals[0]
        self.countryCode2 = countryCode2
        self.countryCode3 = countryCode3
        self.currencies = currencies
        self.region = region
        self.timezones = timezones
        self.flags = flags
        self.continents = continents
        self.capitalCoordinates = capitalCoordinates
        
        self.currencyText = ""
        var c: [String] = []
        for i in 0..<currencies.list.count {
            let currency = currencies.list[i]
            let name = currency.name ?? ""
            let symbol = currency.symbol ?? ""
            
            c.append("\(name)(\(symbol))")
        }
        
        self.currencyText = c.joined(separator: ", ")
    }
    
 
}









