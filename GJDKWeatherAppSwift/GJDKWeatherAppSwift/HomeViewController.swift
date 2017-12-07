//
//  HomeViewController.swift
//  GJDKWeatherAppSwift
//
//  Created by Bhanu on 6/10/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: BaseViewController {
    
    //MARK:IBOutlets
    @IBOutlet weak var getTemperatureButton: UIButton!
    
    @IBOutlet weak var showSavedDataButton: UIButton!
    
    @IBOutlet weak var cityNameTextField: UITextField!
        
    //MARK:Members
    var weatherDeatils : Dictionary<String, Any>?
    
    var locationManager : CLLocationManager!
    
    var currentLocation : CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        determineCurrentLocation()
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
    
    func determineCurrentLocation() -> Void {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
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
        webServiceManager.getWeatherDetails(forTheCity: cityNameTextField.text!) {
            if $0 != nil {
                self.intiateSegue(weatherResults: $0!)
            } else {
                print($1!)
            }
        }
    }
    
    @IBAction func showSavedDataButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "DetailViewSegue", sender: self)
    }
    
    @IBAction func currentCityTemperatureButtonTapped(_ sender: Any) {
        determineCurrentLocation()
        if let currentCityLocation = currentLocation {
            //Call the service passing the location lat and long
           let webServiceManager = WebServiceManager.sharedWebServiceManagerInstance
            webServiceManager.getWeatherDetails(forTheCityWithLattitude: currentCityLocation.coordinate.latitude.description, andLongitude: currentCityLocation.coordinate.longitude.description) {
                if $0 != nil {
                    self.intiateSegue(weatherResults: $0!);
                } else {
                    print($1!)
                }
            }
        } else {
            print("Current Location Co-ordiantes not available")
        }
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

extension HomeViewController : UITextFieldDelegate, CLLocationManagerDelegate {
    //MARK: Text Field Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count > 0 {
            getTemperatureButton.isEnabled = true
        } else if textField.text?.characters.count == 1 {
            getTemperatureButton.isEnabled = false
        }
        return true
    }
    
    //MARK: Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        print("Current Location Latitude is \(currentLocation?.coordinate.latitude)")
        print("Current Location Longitude is \(currentLocation?.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed due to error \(error)")
    }
}
