//
//  WeatherDetailsTableViewCell.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 22/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {
    
    //MARK: Members
    var weatherDetails : WeatherDetails?
    var seeInMapDelegate : SeeInMapActionDelegate?
    
    //MARK: IBOutlets
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: CustomMethods
    func weatherDetailsCellDetails(detailViewController : DetailViewController, weatherDetails : WeatherDetails, cityName : String, temperature : String) -> Void {
        seeInMapDelegate = detailViewController
        self.weatherDetails = weatherDetails
        self.cityName.text = cityName
        self.temperature.text = temperature
    }

    //MARK: IBAction Methods
    @IBAction func seeInMapButtonTapped(_ sender: Any) {
        seeInMapDelegate?.triggerSeeInMapAction(weatherDetails: weatherDetails!)
    }
}
