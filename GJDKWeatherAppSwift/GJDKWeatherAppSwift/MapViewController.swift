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
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.75, longitudeDelta: 0.75)
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

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView : MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        }
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "LighteningIcon")
        }
        return annotationView
    }
}
