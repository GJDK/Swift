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
                let temperature = weatherInfo["temperature"] as! Double
                temperatureLabel.text = convertToCelsius(fromKelvin: temperature)
            }
        }
    }
    
    //MARK: IBAction Methods
    @IBAction func saveDataButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.isCityAlreadyExists(String(self.weatherDetails!["cityId"]! as! Double)) {
            let alert = UIAlertController(title: "Alert", message: "City Record Already Exists", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let weatherDetails = WeatherDetails(context: appDelegate.persistentContainer.viewContext)
            weatherDetails.cityId = String(self.weatherDetails!["cityId"]! as! Double)
            weatherDetails.cityName = (self.weatherDetails!["cityName"]! as! String)
            weatherDetails.temperature = convertToCelsius(String(self.weatherDetails!["temperature"]! as! Double))
            appDelegate.saveContext()
            performSegue(withIdentifier: "DetailSegue", sender: self)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            _ = segue.destination as! DetailViewController
            
        }
    }

}
