//
//  ViewController.swift
//  DeviceMotion
//
//  Created by kooapps on 4/18/21.
//

import UIKit
import CoreLocation
import CoreMotion

class ViewController: UIViewController, CLLocationManagerDelegate {

    let lm = CLLocationManager()
    let mm = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lm.requestWhenInUseAuthorization()
        lm.requestAlwaysAuthorization()
        
        lm.delegate = self
        lm.startUpdatingLocation()
        lm.startUpdatingHeading()
        
        mm.startAccelerometerUpdates(to: OperationQueue()) {
            (data, error) in
            if let data = data {
                let tmp = data.acceleration
                print("(x, y, z) = (\(tmp.x), \(tmp.y), \(tmp.z)")
            }
        }
        
        mm.startGyroUpdates(to: OperationQueue()) {
            (data, error) in
            if let data = data {
                let tmp = data.rotationRate
                print("(x, y, z) = (\(tmp.x), \(tmp.y), \(tmp.z)")
            }
        }
        
        mm.startMagnetometerUpdates(to: OperationQueue()){
            (data, error) in
            if let data = data {
                let tmp = data.magneticField
                print("(x, y, z) = (\(tmp.x), \(tmp.y), \(tmp.z)")
            }
        }
        
        mm.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue()) {
            (motion, error) in
            if let motion = motion {
                let attitude = motion.attitude
                print("(\(attitude.pitch), \(attitude.roll), \(attitude.yaw)")
                
                let rotation = motion.rotationRate
                print("(\(rotation.x), \(rotation.y), \(rotation.z)")
                
                let gravity = motion.gravity
                print("(\(gravity.x), \(gravity.y), \(gravity.z)")
                
                let acceleration = motion.userAcceleration
                print("(\(acceleration.x), \(acceleration.y), \(acceleration.z)")
                
                let magnetic = motion.magneticField
                print("(\(magnetic.field.x), \(magnetic.field.y), \(magnetic.field.z)")
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("latitude: \(location.coordinate.latitude)")
            print("longitude: \(location.coordinate.longitude)")
            print("altitude: \(location.altitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.headingAccuracy < 0 {
            print("請進行校正 遠離磁性干擾源")
        } else {
            print("current Heading : \(newHeading.magneticHeading)")
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
        }
    }


}

