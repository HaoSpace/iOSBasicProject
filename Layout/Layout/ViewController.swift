//
//  ViewController.swift
//  Layout
//
//  Created by kooapps on 4/13/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        switch traitCollection.userInterfaceIdiom {
        case .pad:
            print("iPad")
        case .phone:
            print("iPhone")
        case .tv:
            print("Apple TV")
        case .carPlay:
            print("car")
        case .unspecified:
            print("unknown")
        case .mac:
            print("mac")
        default:
            print("nothing")
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        if newCollection.horizontalSizeClass == .compact{
            print("Compact Width")
        }
        else if newCollection.horizontalSizeClass == .regular {
            print("Regular Width")
        }
        
        if newCollection.verticalSizeClass == .compact{
            print("Compact Height")
        }
        else if newCollection.verticalSizeClass == .regular{
            print("Reqular Height")
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        switch UIDevice.current.orientation{
        case .faceDown:
            print("faceDown")
        case .faceUp:
            print("faceUp")
        case.landscapeLeft:
            print("landscapeLeft")
        case .landscapeRight:
            print("landscapeRight")
        case .portrait:
            print("portrait")
        case .portraitUpsideDown:
            print("portraitUpsideDown")
        case .unknown:
            print("unknown")
        default:
            print("default")
            
        }
        
        print("(\(size.width), \(size.height)")
    }


}

