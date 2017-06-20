//
//  HomeViewController.swift
//  GJDKWeatherAppSwift
//
//  Created by Bhanu on 6/10/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:IBOutlets
    @IBOutlet weak var getTemperatureButton: UIButton!
    
    @IBOutlet weak var showSavedDataButton: UIButton!
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Action Methods
    @IBAction func getTemperatureButtonTapped(_ sender: Any) {
        cityNameTextField.resignFirstResponder()
        let webServiceManager = WebServiceManager.sharedWebServiceManagerInstance
        webServiceManager.getWeatherDetails(forTheCity: cityNameTextField.text!) { (WeatherInfo) in
            print(WeatherInfo!)
        }
    }
    
    @IBAction func showSavedDataButtonTapped(_ sender: Any) {
    }
    
    //MARK: Text Field Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Hi")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count > 0 {
            getTemperatureButton.isEnabled = true
        } else if textField.text?.characters.count == 1 {
            getTemperatureButton.isEnabled = false
        }
        return true
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
