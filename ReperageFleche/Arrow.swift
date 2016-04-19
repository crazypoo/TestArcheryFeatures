//
//  Arrow.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 11/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit

class Arrow: Hashable {
    
    var oldLocation : CGPoint
    var location : CGPoint {
        return CGPoint(x: self.oldLocation.x - Constante.TargetScale, y: self.oldLocation.y - Constante.TargetScale)
    }
    var xPos : CGFloat { return location.x }
    var yPos : CGFloat { return location.y }
    var value : Int { return setValue() }
    
    var arrowId : Int
    var hashValue: Int{ return self.arrowId }
    
    
    
    struct Constante {
        static let TargetScale : CGFloat = 350/2      // Constante à definir selon la taille du blason sur l'ecran. Ici le blason fait 350 pixels de coté.
    }
    
    init(id: Int, primaryLocation : CGPoint) {
        self.arrowId = id
        self.oldLocation = primaryLocation
        print("location : \(location)")
        print("VALUE : \(value)")
    }
    
    func setValue() -> Int {
        let r = sqrt(xPos*xPos + yPos*yPos)
        let value = Int(((Constante.TargetScale - r)/Constante.TargetScale * 10)+1)
        return max(0,min(100,value))
    }

}

func ==(lhs: Arrow, rhs: Arrow) -> Bool {
    return lhs.arrowId == rhs.arrowId
}
