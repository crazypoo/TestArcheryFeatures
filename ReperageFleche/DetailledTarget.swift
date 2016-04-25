//
//  DetailledTarget.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 23/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit

class DetailledTarget: UIViewController {
    
    
    var arrow : Arrow!
    
    var reperageViews = [CrossMarkerView]()
    
    @IBOutlet weak var targetImageView: UIImageView!
    @IBOutlet weak var arrowTextLabel: UILabel!
    
    @IBOutlet weak var endCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
    
        arrowTextLabel.text = "Flèche numero : \(arrow.arrowId+1)"
        
        var scoreTotal : Int = 0
        for i in arrow.shots {
            scoreTotal += i.value
        }
        
        scoreLabel.text = "Score Total : \(scoreTotal)"
        endCountLabel.text = "Nombre d'impact : \(arrow.shots.count)"
        
        updateMarkers(arrow.shots)
    }
    
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
