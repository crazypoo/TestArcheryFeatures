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

    var reperageViews : [CrossMarkerView] = [CrossMarkerView]()
    
    
    func updateMarkers(shots : [Shot]){
    
        for i in reperageViews {
            i.removeFromSuperview()
        }
        reperageViews.removeAll()
        
        for currentShot in shots {
            reperageViews.append(CrossMarkerView(shot: currentShot, frame: targetImageView.bounds))
            
            targetImageView.addSubview(reperageViews.last!)
        }
        
    }
    
    
}
