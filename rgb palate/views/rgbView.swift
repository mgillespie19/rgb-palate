//
//  rgbController.swift
//  rgb palate
//
//  Created by Max Gillespie on 11/30/18.
//  Copyright © 2018 Max Gillespie. All rights reserved.
//
import Foundation
import UIKit

class rgbView: UIViewController {
    // variable initialization
    let bgdColor = UIColor.white
    let cwRadius = 150
    var cwCenter = CGPoint(x: 0, y: 0) // color wheel
    var cpCenter = CGPoint(x: 0, y: 0) // color picker
    var currentRGB: [Int?] = [0, 0, 0]
    let pi = Double.pi
    
    lazy var colorWheel: CAShapeLayer = {
        let cw = CAShapeLayer()
        let colorWheelPath = UIBezierPath(arcCenter: cwCenter, radius: CGFloat(cwRadius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        cw.path = colorWheelPath.cgPath
        cw.fillColor = UIColor.clear.cgColor
        cw.strokeColor = UIColor.black.cgColor
        cw.lineWidth = 2
        
        return cw
    }()
    lazy var colorPicker:UIImageView = {
        let cp = UIImageView(frame: CGRect(x: 30, y: 30, width: 10, height: 10))
        cp.backgroundColor = UIColor.black
        cp.cornerRadius = 5
        
        return cp
    }()
    
    
    // program initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBgd(touchPoint: CGPoint(x: cwCenter.x, y: cwCenter.y), init_seq: true)
        
        cwCenter.x = self.view.frame.width / 2
        cwCenter.y = self.view.frame.height * 2 / 3
        colorPicker.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height * 2 / 3)
        
        self.view.layer.addSublayer(colorWheel)
        self.view.addSubview(colorPicker)
    }

    
    // touch interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        
        if colorWheel.path!.contains(touchPoint) {
            colorPicker.center = touchPoint
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        
        if colorWheel.path!.contains(touchPoint) {
            colorPicker.center = touchPoint
            updateBgd(touchPoint:touchPoint, init_seq:false)
        }
    }
    
    
    func updateBgd(touchPoint:CGPoint, init_seq:Bool) {
        let dx = touchPoint.x-cwCenter.x
        let dy = cwCenter.y-touchPoint.y
        let saturation:Double = sqrt( Double(pow(dx, 2)) + Double(pow(dy, 2)) ) / Double(cwRadius)
        let slope = dy/dx
        var hue:Double = 0
        //print(slope)
        
        if touchPoint.x >= cwCenter.x && touchPoint.y <= cwCenter.y {
//            print ("0-90")
            
            hue = Double(atan(slope))
            //print(hue)
        } else if touchPoint.x <= cwCenter.x && touchPoint.y >= cwCenter.y {
//            print ("180-270")
            
            hue = pi + Double(atan(slope))
            //print(hue)
        } else if touchPoint.x >= cwCenter.x && touchPoint.y >= cwCenter.y {
//            print("270-360")
            
            hue = Double(atan(slope)) + 2*pi
            //print(hue)
        } else { // slope > 1
//            print("90-180")
            hue = Double(atan(slope)) + pi
            //print(hue)
        }
        
        hue = hue/(2*pi)
//        print(hue)

        self.view.backgroundColor = UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: 1, alpha: 1)
        self.tabBarController?.tabBar.barTintColor =  UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: 1, alpha: 1)
        
        if (init_seq) {
            navigationItem.title = "R:0 / G:0 / B:0"
        } else {
            var hsvArr = hsv(hue: Int(hue*360), saturation: Double(saturation), value: Double(saturation))
            navigationItem.title = "R:\(String(hsvArr[0])) / G:\(String(hsvArr[1])) / B:\(String(hsvArr[2]))"
        }
        
    }
    
    // hue in range [0, 360]
    // saturation, value in range [0,1]
    // return [r,g,b] each in range [0,255]
    func hsv(hue:Int, saturation:Double, value:Double) ->[Int] {
        let chroma = value * saturation
        let hue1 = hue / 60
        let x = chroma * Double(1 - abs((hue1 % 2) - 1))
        var r = Double(0)
        var g = Double(0)
        var b = Double(0)
        
        if (hue1 >= 0 && hue1 <= 1) {
            r = Double(chroma)
            g = Double(x)
            b = Double(0)
        } else if (hue1 >= 1 && hue1 <= 2) {
            r = Double(x)
            g = Double(chroma)
            b = Double(0)
        } else if (hue1 >= 2 && hue1 <= 3) {
            r = Double(0)
            g = Double(chroma)
            b = Double(x)
        } else if (hue1 >= 3 && hue1 <= 4) {
            r = Double(0)
            g = Double(x)
            b = Double(chroma)
        } else if (hue1 >= 4 && hue1 <= 5) {
            r = Double(x)
            g = Double(0)
            b = Double(chroma)
        } else if (hue1 >= 5 && hue1 <= 6) {
            r = Double(chroma)
            g = Double(0)
            b = Double(x)
        }
        
        let m = Double(value - chroma)
        r += Double(m)
        g += Double(m)
        b += Double(m)
        
        //print(r)
        
        
        // Change r,g,b values from [0,1] to [0,255]
        return [Int(r * 255), Int(g*255), Int(b*255)]
    }
    
}
