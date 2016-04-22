//
//  HomePageViewController.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 22/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var stepper: UIStepper!{
        didSet{
            stepper.wraps = true
            stepper.maximumValue = 15
            stepper.minimumValue = 1
        }
    }
    @IBOutlet weak var nbrsArrowLabel: UILabel!
    
    var nbrsArrow : Int = 1 {
        didSet {
            nbrsArrowLabel.text = String(nbrsArrow)
        }
    }
    
    @IBAction func stepperAction(sender: UIStepper) {
        nbrsArrow = Int(sender.value)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? TargetViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "letsGoSegue":
                   dvc.nbrsArrow = nbrsArrow
                   dvc.nbrsEnd = 0
                default:
                    break
                }
            }
        }
    }
    
}
