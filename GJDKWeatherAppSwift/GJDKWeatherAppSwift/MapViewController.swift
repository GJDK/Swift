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
    
    //MARK: Members
    var cityDetails : WeatherDetails!

    //MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        zoomToTheSelectedCity()
        addPinToTheLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Custom methods
    func zoomToTheSelectedCity() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: cityDetails.latitude, longitude: cityDetails.longitude)
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: coordinateSpan)
        mapView.setRegion(region, animated: true)
    }
    
    func addPinToTheLocation() {
        let annotations = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: cityDetails.latitude, longitude: cityDetails.longitude)
        annotations.coordinate = centerCoordinate
        annotations.title = cityDetails.cityName
        mapView.addAnnotation(annotations)
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
