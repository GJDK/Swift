//
//  SeeInMapActionDelegate.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 30/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import Foundation

protocol SeeInMapActionDelegate {
    func triggerSeeInMapAction(weatherDetails : WeatherDetails) -> Void
}
