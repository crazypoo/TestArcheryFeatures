//
//  File.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 17/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit

class ResultViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrowTab : [Arrow]!
    var nbrsEnd : Int!
    @IBOutlet weak var targetCollectionView: UICollectionView!
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let targetCell = collectionView.dequeueReusableCellWithReuseIdentifier("targetCellIdentifier", forIndexPath: indexPath) as! TargetImageCell
        targetCell.arrow = arrowTab[indexPath.item]
        
        return targetCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrowTab.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier{
            
            switch identifier {
            case "shootAgainSegue" :
                if let dvc = segue.destinationViewController as? TargetViewController{
                    dvc.nbrsEnd = nbrsEnd + 1
                    dvc.nbrsArrow = arrowTab.count
                    dvc.arrowTab = arrowTab
                    self.navigationController?.viewControllers.removeAll()
                }
            case "resetArrowSegue" :                     self.navigationController?.viewControllers.removeAll()

            
            case "showDetailledTarget" :
                if let dvc = segue.destinationViewController as? DetailledTarget {
                
                    let selectedCell = sender as! TargetImageCell
                    
                    let indexPath = self.targetCollectionView.indexPathForCell(selectedCell)
                        
                    dvc.arrow = arrowTab[indexPath!.item]
                }
            default : break
            }
        }
        
    }
    
}
