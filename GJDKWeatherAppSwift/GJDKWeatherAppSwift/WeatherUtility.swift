//
//  WeatherUtility.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 21/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import Foundation

enum ServiceFailure : Error {
    case CityNameNotFound, TemperatureNotFound, CityIdNotFound
}

