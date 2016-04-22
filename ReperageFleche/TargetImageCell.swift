//
//  TargetImageCell.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 21/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit

class TargetImageCell: UICollectionViewCell {

    var arrow : Arrow! {
        didSet{
            arrowIDLAbel.textColor = UIColor.blueColor()
            arrowIDLAbel.text = String(arrow.arrowId + 1)
            updateMarkers(arrow.shots)
        }
        
    }
    
    @IBOutlet weak var targetImageView: UIImageView!
    
    @IBOutlet weak var arrowIDLAbel: UILabel!

    var reperageViews : [CrossMarkerView]!
    
    
    func updateMarkers(shots : [Shot]){
        
        reperageViews = [CrossMarkerView]()
        var j : Int = 1
        for currentShot in shots {
            
            print("location of marker : \(shots) for the arrow n° \(arrow.arrowId) and the end n° \(j)")
            
            reperageViews.append(CrossMarkerView(shot: currentShot, frame: targetImageView.bounds))
            
            targetImageView.addSubview(reperageViews.last!)
            j += 1
        }
        
    }
    
    
}
