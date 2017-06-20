//
//  WebServiceManager.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 20/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import Foundation

let BaseUrl = "http://api.openweathermap.org/data/2.5/weather?q=%@&appid=8726c36d19324fd1f9e2cf1d359a7760"

class WebServiceManager {
    static let sharedWebServiceManagerInstance = WebServiceManager()
    
    func getWeatherDetails(forTheCity cityName : String, withCompletionHandler weatherDetailsBlock : @escaping (_ result : Dictionary<String, Any>?) -> Void) -> Void {
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: urlSessionConfiguration)
        var url : URL?
        let urlString = String(format: BaseUrl, cityName)
        url = URL.init(string: urlString)
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let weatherInfo = try? JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                print(weatherInfo!)
                
                let cityNameFromWeatherInfo = weatherInfo!["name"] as! String
                let temperature = (weatherInfo!["main"] as! Dictionary<String, Any>)["temp"] as! Double
                let cityId = weatherInfo!["id"] as! Double
                
                let weatherDetails = ["cityName" : cityNameFromWeatherInfo, "temperature" : temperature, "cityId" : cityId] as [String : Any]
                print(weatherDetails)
                
                weatherDetailsBlock(weatherDetails)
            }
        }
        dataTask.resume()
    }
}
