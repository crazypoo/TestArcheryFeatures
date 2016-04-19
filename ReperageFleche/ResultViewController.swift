//
//  File.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 17/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var arrowTab : [Arrow]!{
        didSet{
            for i in arrowTab {
                print(i.value)
            }
        }
    }
    
    var targetImage : UIImage!
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.image = targetImage
        }
    }
    
    @IBAction func OkayButtonAction(sender: UIButton) {
        performSegueWithIdentifier("resultToTarget", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? TargetViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "resultToTarget" : dvc.arrowTab = [Arrow]()
                default : break
                }
            }
        }
    }
    
}
