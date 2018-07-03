//
//  CountryChoose.swift
//  TestTaskRegistrationForm
//
//  Created by JigSaw on 03.07.2018.
//  Copyright © 2018 poulkravtsoff. All rights reserved.
//

import Foundation

enum LoaderError: Error {
    case arrayFailed
    case pathFailed
}

class CountriesLoader {
    public func loadCountries() throws -> [String] {
        var countries = [String]()
        if let path = Bundle.main.path(forResource: "Countries", ofType: "plist"){
            if let array = NSArray(contentsOfFile: path) as? [Dictionary<String, Any>] {
                for dictionary in array {
                    let country = dictionary["name"] as! String
                    countries.append(country)
                }
                return countries
            }else{
                throw LoaderError.arrayFailed
            }
        }else{
            throw LoaderError.pathFailed
        }
    }
}
