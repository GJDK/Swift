//
//  HomeViewController.swift
//  GJDKWeatherAppSwift
//
//  Created by Bhanu on 6/10/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITextFieldDelegate {
    
    //MARK:IBOutlets
    @IBOutlet weak var getTemperatureButton: UIButton!
    
    @IBOutlet weak var showSavedDataButton: UIButton!
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    //MARK:Members
    var weatherDeatils : Dictionary<String, Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let weatherDetails = (UIApplication.shared.delegate as! AppDelegate).fetchSavedData()
        if let weatherInfo = weatherDetails {
            if weatherInfo.count > 0 {
                showSavedDataButton.isEnabled = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Custom Methods
    func intiateSegue(weatherResults: Dictionary<String, Any>) -> Void {
        weatherDeatils = weatherResults
        let operationQueue = OperationQueue.main
        operationQueue.addOperation {
            self.performSegue(withIdentifier: "resultSegue", sender: self)
        }
    }

    //MARK: Action Methods
    @IBAction func getTemperatureButtonTapped(_ sender: Any) {
        cityNameTextField.resignFirstResponder()
        let webServiceManager = WebServiceManager.sharedWebServiceManagerInstance
        webServiceManager.getWeatherDetails(forTheCity: cityNameTextField.text!) { (WeatherInfo, error) in
            if let weatherDict = WeatherInfo {
                self.intiateSegue(weatherResults: weatherDict)
            } else {
                print(error!) 
            }
        }
    }
    
    @IBAction func showSavedDataButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "DetailViewSegue", sender: self)
    }
    
    //MARK: Text Field Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count > 0 {
            getTemperatureButton.isEnabled = true
        } else if textField.text?.characters.count == 1 {
            getTemperatureButton.isEnabled = false
        }
        return true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            let resultViewCoontroller = segue.destination as! ResultViewController
            if let weatherInfo = weatherDeatils {
                if (weatherInfo.count) > 0 {
                    resultViewCoontroller.weatherDetails = weatherInfo
                }
            } else {
                resultViewCoontroller.weatherDetails = nil
            }
        } else if segue.identifier == "DetailViewSegue" {
            _ = segue.destination as! DetailViewController
            
        }
    }
}
