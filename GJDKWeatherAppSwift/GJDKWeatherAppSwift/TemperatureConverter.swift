//
//  TemperatureConverter.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 27/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import Foundation

struct TemperatureConversion {
    let deductionValue : Double
    
    subscript(index : Double) -> String {
        let celsius = index - deductionValue
        return String(format: "%.1f c", celsius)
    }
    
    subscript(index : String) -> String {
        let temperature = Double(index)
        let celsius = temperature! - deductionValue
        return String(format: "%.1f c", celsius)
    }
}
