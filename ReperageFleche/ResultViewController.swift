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
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let targetCell = collectionView.dequeueReusableCellWithReuseIdentifier("targetCellIdentifier", forIndexPath: indexPath) as! TargetImageCell
        targetCell.arrow = arrowTab[indexPath.item]
        
        return targetCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrowTab.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let dvc = segue.destinationViewController as? TargetViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "shootAgainSegue" :
                    dvc.nbrsEnd = nbrsEnd + 1
                    dvc.nbrsArrow = arrowTab.count
                    dvc.arrowTab = arrowTab
                case "resetArrrowSegue" : dvc.arrowTab = [Arrow]()
                default : break
                }
            }
        }
    }
    
}
