//
//  ResultViewController.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 20/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    //MARK: IBOutlets

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    //MARK: Members
    var weatherDetails : Dictionary<String, Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Custom Methods
    func updateValues() -> Void {
        if let weatherInfo = weatherDetails {
            if weatherInfo.count > 0 {
                cityNameLabel.text = (weatherInfo["cityName"] as! String)
                let tempertur = (weatherInfo["temperature"] as! Double)
                let temperature = convertToCelsius(fromKelvin: Float(tempertur))
                temperatureLabel.text = String(format: "%.1f", temperature)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
