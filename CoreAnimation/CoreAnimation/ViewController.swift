//
//  ViewController.swift
//  CoreAnimation
//
//  Created by kooapps on 4/17/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var imageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        border(in: myView.layer)
        shadow(in: myView.layer)
        cornerRadius(in: myView.layer)
        myView.layer.setAffineTransform(rotate().concatenating(scale()))
        
        //for right top image
        let shadowLayer = CALayer()
        shadowLayer.frame = myView.frame
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadow(in: shadowLayer)
        view.layer.insertSublayer(shadowLayer, below: imageView.layer)
        print(imageView.frame)
        print(shadowLayer.frame)
        cornerRadius(in: shadowLayer)
        cornerRadius(in: imageView.layer)
        
        //add image to layer
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: 50, y: 200, width: 130, height: 130)
        imageLayer.contents = UIImage(named: "1.png")?.cgImage
        imageLayer.contentsGravity = .resizeAspectFill
        imageLayer.masksToBounds = true
        
        view.layer.addSublayer(imageLayer)
        
        //add text on view
        let textLayer = CATextLayer()
        textLayer.string = "image demo"
        let font = UIFont(name: "Zapfino", size: 19)
        textLayer.font = font
        textLayer.fontSize = font?.pointSize ?? 17
        textLayer.foregroundColor = UIColor.lightGray.cgColor
        textLayer.frame = imageView.frame
        textLayer.contentsScale = UIScreen.main.scale
        view.layer.addSublayer(textLayer)
        
        //add shape
        let path1 = UIBezierPath(rect: CGRect(x: 50, y: 360, width: 100, height: 100))
        let path2 = UIBezierPath(roundedRect: CGRect(x: 200, y: 360, width: 120, height: 80), cornerRadius: 10.0)
        
        path1.append(path2)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.path = path1.cgPath
        
        view.layer.addSublayer(shapeLayer)
        
        //gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 50, y: 500, width: 100, height: 100)
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.cyan.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0.1, 0.6]
        
        view.layer.addSublayer(gradientLayer)
        
        //mask
        let maskLayer = CATextLayer()
        maskLayer.string = "Hello"
        maskLayer.font = font
        maskLayer.fontSize = font?.pointSize ?? 17
        maskLayer.foregroundColor = UIColor.lightGray.cgColor
        maskLayer.frame = imageView.bounds
        maskLayer.contentsScale = UIScreen.main.scale
        imageView.layer.mask = maskLayer
        
        //hitTest
        let greenLayer = CALayer()
        greenLayer.name = "green"
        greenLayer.frame = CGRect(x: 200, y: 500, width: 150, height: 150)
        greenLayer.backgroundColor = UIColor.green.cgColor
        
        let purpleLayer = CALayer()
        purpleLayer.name = "purple"
        purpleLayer.frame = CGRect(x: 300, y: 600, width: 80, height: 120)
        purpleLayer.backgroundColor = UIColor.purple.cgColor
        
        view.layer.addSublayer(greenLayer)
        view.layer.addSublayer(purpleLayer)
        
        //circle animation
        let layer = drawCircle()
        layer.add(strokeEndAnimation(), forKey: nil)
        view.layer.addSublayer(layer)
        
    }


    func border(in layer: CALayer) {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
    
    func shadow(in layer: CALayer) {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 10.0
    }
    
    func cornerRadius(in layer: CALayer) {
        layer.cornerRadius = 10
    }
    
    func rotate() -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: 45.0 * CGFloat.pi / 180.0)
    }
    
    func scale() -> CGAffineTransform {
        return CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: view) else {
            return
        }
        
        guard let layer = view.layer.hitTest(point) else {
            return
        }
        
        guard let layerName = layer.name else {
            return
        }
        
        layer.zPosition += 2
        print(layerName)
    }
    
    func drawCircle() -> CAShapeLayer {
        let path = UIBezierPath(arcCenter: CGPoint(x: 150, y: 300), radius: 70, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = path.cgPath
        
        return shapeLayer
    }
    
    func strokeEndAnimation() -> CABasicAnimation {
        let ani = CABasicAnimation((keyPath: "strokeEnd"))
        ani.duration = 1
        ani.fromValue = 0
        ani.toValue = 0.7
        ani.isRemovedOnCompletion = false
        ani.fillMode = CAMediaTimingFillMode.forwards
        ani.repeatCount = 5
        
        return ani
    }
}

