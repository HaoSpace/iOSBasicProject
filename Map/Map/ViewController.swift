//
//  ViewController.swift
//  Map
//
//  Created by kooapps on 4/16/21.
//

import UIKit
import MapKit
import SafariServices

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ann = [MKPointAnnotation(), MKPointAnnotation()]
        ann[0].coordinate = CLLocationCoordinate2D(latitude: 24.13746, longitude: 121.275753)
        
        ann[0].title = "武嶺"
        ann[0].subtitle = "南投縣仁愛鄉"
        
        ann[1].coordinate = CLLocationCoordinate2D(latitude: 23.510041, longitude: 120.700458)
        
        ann[1].title = "奮起湖"
        ann[1].subtitle = "嘉義縣竹崎鄉"
        mapView.addAnnotations(ann)
        
        mapView.setCenter(ann[0].coordinate, animated: true)
        
        //overlay
        var points = [CLLocationCoordinate2D]()
        points.append(CLLocationCoordinate2D(latitude: 24.2013, longitude: 120.5810))
        points.append(CLLocationCoordinate2D(latitude: 24.2044, longitude: 120.6559))
        points.append(CLLocationCoordinate2D(latitude: 24.1380, longitude: 120.6401))
        points.append(CLLocationCoordinate2D(latitude: 24.1424, longitude: 120.5783))
        
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        mapView.addOverlay(polygon)
        mapView.setCenter(points[0], animated: true)
        
        
        
        //3D
        let ground = CLLocationCoordinate2D(latitude: 48.858356, longitude: 2.294481)
        let eyeFrom = CLLocationCoordinate2D(latitude: 48.847, longitude: 2.294481)
        
        let camera = MKMapCamera(lookingAtCenter: ground, fromEyeCoordinate: eyeFrom, eyeAltitude: 50)
        
        mapView.mapType = .satelliteFlyover
        mapView.isPitchEnabled = true
        mapView.camera = camera
        
        
        //real address
        let location = CLLocation(latitude: 25.102645, longitude: 121.548506)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) {
            (placemarks, error) in
            guard error == nil, placemarks != nil else {
                return
            }
            
            for placemark in placemarks! {
                print(placemark)
                print(placemark.name!)
                print(placemark.country!)
                print(placemark.locality!)
                print(placemark.postalCode!)
                
            }
        }
        
        //address to coordinate
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "台北故宮博物院"
        request.region = mapView.region
        MKLocalSearch(request: request).start {
            (response, error) in
            guard error == nil, response != nil else {
                return
            }
            
            for item in response!.mapItems {
                self.mapView.addAnnotation(item.placemark)
                self.mapView.setCenter(item.placemark.coordinate, animated: true)
            }
        }
        
        
        //導航  不需Mapview
//        let taipei101 = CLLocationCoordinate2D(latitude: 25.033850, longitude: 121.564977)
//        let airstation = CLLocationCoordinate2D(latitude: 25.068554, longitude: 121.552932)
//
//        let pA = MKPlacemark(coordinate: taipei101, addressDictionary: nil)
//        let pB = MKPlacemark(coordinate: airstation, addressDictionary: nil)
//
//        let miA = MKMapItem(placemark: pA)
//        let miB = MKMapItem(placemark: pB)
//        miA.name = "台北101"
//        miB.name = "松山機場"
//
//        let route = [miA, miB]
//        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//
//        MKMapItem.openMaps(with: route, launchOptions: options)
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        
        if annView == nil {
            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            
        }
        
        if (annotation.title)! == "武嶺" {
            annView!.tintColor = .green
            
            let imageView = UIImageView(image: UIImage(named: "4.png"))
            annView!.leftCalloutAccessoryView = imageView
            
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "緯度：\(annotation.coordinate.latitude)\n經度：\(annotation.coordinate.longitude)"
            annView?.detailCalloutAccessoryView = label
            
            let button = UIButton(type: .detailDisclosure)
            button.tag = 100
            button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
            annView!.rightCalloutAccessoryView = button
            annView!.canShowCallout = true
        }
        else if  (annotation.title)! == "奮起湖" {
            annView!.tintColor = .orange
            annView!.image = UIImage(named: "4.png")
            annView!.isDraggable = true
        }
        
        annView!.canShowCallout = true
        
        return annView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        mapView.removeAnnotation(view.annotation!)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == .ending {
            view.dragState = .none
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolygonRenderer(overlay: overlay)
        if overlay is MKPolygon {
            render.fillColor = UIColor.red.withAlphaComponent(0.2)
            render.strokeColor = UIColor.red.withAlphaComponent(0.7)
            render.lineWidth = 3
        }
        
        return render
    }
    
    @objc func buttonPress(_ sender: UIButton) {
        if sender.tag == 100 {
            let url = URL(string: "http://www.taroko.gov.tw")
            let safari = SFSafariViewController(url: url!)
            
            show(safari, sender: self)
        }
    }


}

