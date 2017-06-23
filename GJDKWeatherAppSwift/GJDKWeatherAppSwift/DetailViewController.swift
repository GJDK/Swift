//
//  DetailViewController.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 21/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Members
    var citiesWeatherDetails = [WeatherDetails]()
    
    //MARK: IBOutlets
    @IBOutlet weak var weatherDetailsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherDetailsTableView.tableFooterView = UIView()
        citiesWeatherDetails = (UIApplication.shared.delegate as! AppDelegate).fetchSavedData()!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView Delegate and DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesWeatherDetails.count
    }
    func tableView(_ tableView: UITableView , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherDetailsCell = tableView.dequeueReusableCell(withIdentifier: "CitiesWeatherDetailsCell") as! WeatherDetailsTableViewCell
        weatherDetailsCell.cityName.text = citiesWeatherDetails[indexPath.row].cityName! as String
        //        weatherDetailsCell.temperature.text = citiesWeatherDetails[indexPath.row].temperature! as String
        weatherDetailsCell.temperature.text = convertToCelsius(citiesWeatherDetails[indexPath.row].temperature! as String)
        return weatherDetailsCell
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
