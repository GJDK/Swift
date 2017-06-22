//
//  WeatherDetailsTableViewCell.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 22/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {
    
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

}
