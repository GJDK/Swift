//
//  DetailViewController.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 21/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    //MARK: Members
    var citiesWeatherDetails = [WeatherDetails]()
    var cityDetails : WeatherDetails?
    
    //MARK: IBOutlets
    @IBOutlet weak var weatherDetailsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Remove Back Button and customising it
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "<Back", style: UIBarButtonItemStyle.plain, target: self, action:#selector(DetailViewController.navigateToPreviousController))
        self.navigationItem.leftBarButtonItem = backButton
        
        let refreshButton = UIBarButtonItem(title: "Refresh", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.refreshButtonTapped))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        weatherDetailsTableView.tableFooterView = UIView()
        citiesWeatherDetails = (UIApplication.shared.delegate as! AppDelegate).fetchSavedData()!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Custom Methods
    func navigateToPreviousController() -> Void {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func refreshButtonTapped() -> Void {
        let cityIdDetails = (UIApplication.shared.delegate as! AppDelegate).cityIds()
        (UIApplication.shared.delegate as! AppDelegate).deleteAllRecords()
        if let cityIds = cityIdDetails {
            WebServiceManager.sharedWebServiceManagerInstance.refreshSavedCityDetails(cityIds, withCompletionHandler: { (weatherDetails, error) in
                let cities = weatherDetails?["list"] as! [Dictionary<String, Any>]
                self.updateRefreshedData(cities: cities)
            })
        }
    }
    
    func updateRefreshedData(cities : [Dictionary<String, Any>]) -> Void {
        var cityDetail = Dictionary<String, Any>()
        for city in cities {
            cityDetail = city
            print(cityDetail)
            let weatherDetails = WeatherDetails(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
            weatherDetails.cityId = String(cityDetail["id"]! as! Double)
            weatherDetails.cityName = (cityDetail["name"] as! String)
            weatherDetails.temperature = String(format: "%.1f c", (cityDetail["main"] as! Dictionary<String, Any>)["temp"]! as! Double)
            weatherDetails.latitude = (cityDetail["coord"] as! Dictionary<String, Any>)["lat"]! as! Double
            weatherDetails.longitude = (cityDetail["coord"] as! Dictionary<String, Any>)["lon"]! as! Double
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        citiesWeatherDetails = (UIApplication.shared.delegate as! AppDelegate).fetchSavedData()!
        let operationQueue = OperationQueue.main
        operationQueue.addOperation { 
            self.weatherDetailsTableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapViewSegue" {
            let mapViewController = segue.destination as! MapViewController
            if let cityInfo = cityDetails {
                mapViewController.cityDetails = cityInfo
            }
        }
    }
}

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    //MARK: TableView Delegate and DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesWeatherDetails.count
    }
    
    func tableView(_ tableView: UITableView , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherDetailsCell = tableView.dequeueReusableCell(withIdentifier: "CitiesWeatherDetailsCell") as! WeatherDetailsTableViewCell
        
        weatherDetailsCell.weatherDetailsCellDetails(detailViewController: self, weatherDetails: citiesWeatherDetails[indexPath.row], cityName: citiesWeatherDetails[indexPath.row].cityName! as String, temperature: citiesWeatherDetails[indexPath.row].temperature! as String)
        
        return weatherDetailsCell
    }
}

extension DetailViewController : SeeInMapActionDelegate {
    //MARK: SeeInMapActionDelegate Methods
    func triggerSeeInMapAction(weatherDetails: WeatherDetails) {
        cityDetails = weatherDetails
        performSegue(withIdentifier: "mapViewSegue", sender: self)
    }
}
