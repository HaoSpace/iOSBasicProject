//
//  MyCanvas.swift
//  Drawing
//
//  Created by kooapps on 4/17/21.
//

import UIKit

class MyCanvas: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()
            
            var t = context.ctm
            t = t.inverted()
            context.concatenate(t)
            
            drawLine(in: context)
            drawPoligon(in: context)
            drawRectangle(in: context)
            drawArc(in: context)
            drawEllipse(in: context)
            drawCurve(in: context)
            drawImage(in: context)
            context.restoreGState()
        }
        
    }
    
    func drawLine (in context: CGContext) {
        context.setLineWidth(15)
        context.setStrokeColor(red: 0, green: 0, blue: 1, alpha: 1)
        
        context.move(to: CGPoint(x: 10, y: 100))
        context.addLine(to: CGPoint(x: 200, y: 100))
        context.drawPath(using: .stroke)
        
        let dashes: [CGFloat] = [6, 6, 2, 3]
        context.setLineDash(phase: 0, lengths: dashes)
        context.move(to: CGPoint(x: 10, y: 150))
        context.addLine(to: CGPoint(x: 200, y: 150))
        context.drawPath(using: .stroke)
        
        let dashes2: [CGFloat] = [10, 10]
        context.setLineDash(phase: 0, lengths: dashes2)
        context.move(to: CGPoint(x: 10, y: 200))
        context.addLine(to: CGPoint(x: 200, y: 200))
        context.drawPath(using: .stroke)
        
    }
    
    func drawPoligon (in context: CGContext) {
        context.setLineDash(phase: 0, lengths: [])
        context.setStrokeColor(red: 0, green: 0, blue: 1, alpha: 1)
        context.setFillColor(red: 0.6, green: 1, blue: 1, alpha: 1)
        context.setLineWidth(15)
        
        context.beginPath()
        context.move(to: CGPoint(x: 30, y: 250))
        context.addLine(to: CGPoint(x: 200, y: 250))
        context.addLine(to: CGPoint(x: 200, y: 420))
        context.closePath()
        
        context.drawPath(using: .fillStroke)
    }
    
    func drawRectangle (in context: CGContext) {
        context.setFillColor(red: 1, green: 0, blue: 0, alpha: 1)
        context.addRect(CGRect(x: 30, y: 450, width: 100, height: 100))
        context.drawPath(using: .fill)
        
        context.setFillColor(red: 0, green: 1, blue: 0, alpha: 0.4)
        context.addRect(CGRect(x: 80, y: 500, width: 200, height: 200))
        context.drawPath(using: .fill)
    }
    
    func drawArc (in context: CGContext) {
        context.setLineWidth(10)
        context.setStrokeColor(red: 0, green: 0, blue: 1, alpha: 1)
        
        context.addArc(center: CGPoint(x: 200, y: 650), radius: 50, startAngle: 0, endAngle: 90 * CGFloat.pi / 180, clockwise: false)
        
        context.addArc(center: CGPoint(x: 200, y: 800), radius: 100, startAngle: 270 * CGFloat.pi / 180, endAngle: 0, clockwise: true)
        
        context.drawPath(using: .stroke)
    }
    
    func drawEllipse (in context: CGContext) {
        context.setFillColor(red: 0, green: 0, blue: 1, alpha: 1)
        
        context.addEllipse(in: CGRect(x: 30, y: 950, width: 200, height: 80))
        context.drawPath(using: .fill)
        
        context.addEllipse(in: CGRect(x: 70, y: 1080, width: 150, height: 150))
        context.drawPath(using: .eoFillStroke)
    }
    
    func drawCurve (in context: CGContext) {
        context.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
        context.setLineWidth(3)
        
        //三次貝茲
        context.move(to: CGPoint(x: 70, y: 1280))
        context.addCurve(to: CGPoint(x: 250, y: 1280), control1: CGPoint(x: 100, y: 1580), control2: CGPoint(x: -80, y: 1280))
        context.drawPath(using: .stroke)
        
        //二次貝茲
        context.move(to: CGPoint(x: 120, y: 1380))
        context.addQuadCurve(to: CGPoint(x: 100, y: 1229), control: CGPoint(x: -100, y: 1000))
        context.drawPath(using: .stroke)
    }
    
    func drawImage (in context: CGContext) {
        let image = UIImage(named: "2.png")?.cgImage
        
        context.draw(image!, in: CGRect(x: 200, y: 100, width: 500, height: 500))
        let subRect = CGRect(x: 700, y: 700, width: 200, height: 200)
        let subImage = image!.cropping(to: subRect)
//
        context.draw(subImage!, in: CGRect(x: 200, y: 750, width: 400, height: 400))
    }
    

}
