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
    var sourceLocation : CLLocationCoordinate2D?
    var destinationLocation : CLLocationCoordinate2D?
    

    //MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sourceLocation = CLLocationCoordinate2D(latitude: 28.67, longitude: 77.22)
        destinationLocation = CLLocationCoordinate2D(latitude: cityDetails.latitude, longitude: cityDetails.longitude)
        addFindDistanceButton()
        zoomToTheSelectedCity()
        addPinToTheLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Custom methods
    func addFindDistanceButton() -> Void {
        let rightBarButtonItem = UIBarButtonItem(title: "Find Distance", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MapViewController.findDistanceButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func findDistanceButtonTapped(sender : Any) -> Void {
        drawRoute()
    }
    
    func drawRoute() -> Void {
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation!)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation!)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
        
        let sourceAnnotation = MKPointAnnotation()
        let destinationAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Delhi - Current Location"
        destinationAnnotation.title = cityDetails.cityName!
        sourceAnnotation.coordinate = (sourcePlaceMark.location?.coordinate)!
        destinationAnnotation.coordinate = (destinationPlaceMark.location?.coordinate)!
        
        mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = MKDirectionsTransportType.any
        directionRequest.requestsAlternateRoutes = true;
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func zoomToTheSelectedCity() {
        let centerCoordinate = destinationLocation!
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.75, longitudeDelta: 0.75)
        let region = MKCoordinateRegion(center: centerCoordinate, span: coordinateSpan)
        mapView.setRegion(region, animated: true)
    }
    
    func addPinToTheLocation() {
        let annotations = MKPointAnnotation()
        let centerCoordinate = destinationLocation!
        annotations.coordinate = centerCoordinate
        annotations.title = cityDetails.cityName!
        annotations.subtitle = cityDetails.temperature!
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
    }
}
