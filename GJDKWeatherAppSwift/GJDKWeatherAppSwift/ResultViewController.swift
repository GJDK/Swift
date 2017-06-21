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
        performSegue(withIdentifier: "DetailSegue", sender: self)
        
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            _ = segue.destination as! DetailViewController
            
        }
    }

}
