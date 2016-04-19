//
//  CrossMarkerView.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 18/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit

class CrossMarkerView: UIView {
    
    var arrow : Arrow
    
    init(arrow: Arrow){
        self.arrow = arrow
        
        super.init(frame: CGRectMake(0, 0, 350, 350))
        self.backgroundColor = UIColor.clearColor()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        if arrow.value == 7 || arrow.value == 8 {
            UIColor.blackColor().set()
        } else { UIColor.redColor().set() }
        
        setCrossPath(arrow).stroke()
        
    }
    
    struct  Constants {
        static let crossSize : CGFloat = 5
    }
    
    func setCrossPath(arrow : Arrow) -> UIBezierPath {
        let crossSize = Constants.crossSize
        let point = arrow.oldLocation
        let path = UIBezierPath()
        
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
