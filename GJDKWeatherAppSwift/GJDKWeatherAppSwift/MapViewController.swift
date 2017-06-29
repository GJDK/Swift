//
//  MapViewController.swift
//  GJDKWeatherAppSwift
//
//  Created by Denesh on 29/06/17.
//  Copyright © 2017 Prokarma. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    //MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let annotations = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: 9.93, longitude: 78.12)
        annotations.coordinate = centerCoordinate
        annotations.title = "Madurai"
        mapView.addAnnotation(annotations)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
