//
//  CrossMarkerView.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 18/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit

class CrossMarkerView: UIView {
    
    var shot : Shot
    
    //scale depend de taille. frame.heigt => nouvelle taille, 350 taille de depart.
    var scale : CGFloat

    
    init(shot: Shot, frame: CGRect){
        self.shot = shot
        self.scale = frame.size.height/Constants.firstTargetSize

        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        UIColor.redColor().set()
        
        if shot.value == 7 || shot.value == 8 {
            UIColor.blackColor().set()
        }
        
        setCrossPath().stroke()
    }
    
    struct  Constants {
        static let crossSize : CGFloat = 5
        static let firstTargetSize : CGFloat = 350
    }
    
    func setCrossPath() -> UIBezierPath {
        let crossSize = Constants.crossSize
        let path = UIBezierPath()
        
        let point = CGPoint(x: shot.location.x * scale, y: shot.location.y * scale)
        
        path.moveToPoint(CGPoint(x: point.x - crossSize, y: point.y - crossSize))
        path.addLineToPoint(CGPoint(x: point.x, y: point.y))
        
        path.moveToPoint(CGPoint(x: point.x + crossSize, y: point.y - crossSize))
        path.addLineToPoint(CGPoint(x: point.x , y: point.y))
        
        path.moveToPoint(CGPoint(x: point.x , y: point.y + crossSize))
        path.addLineToPoint(CGPoint(x: point.x , y: point.y))
        
        path.lineWidth = 2.0

        setNeedsDisplay()
        
        return path
    }
    
}
