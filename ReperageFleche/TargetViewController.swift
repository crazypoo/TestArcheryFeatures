//
//  ViewController.swift
//  ReperageFleche
//
//  Created by Rémy Vermeersch  on 11/04/2016.
//  Copyright © 2016 Rémy Vermeersch . All rights reserved.
//

import UIKit
import MobileCoreServices

class TargetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    //MARK: -Arrow Gesture
    var arrowTab = [Arrow](){
        didSet{
            if TargetView != nil {
                
                if arrowTab.isEmpty {
                    CorrectButton.enabled = false
                } else { CorrectButton.enabled = true}
                
                if arrowTab.count == 6 {
                    SendButton.enabled = true
                } else { SendButton.enabled = false }
                
                updateUI()
            }
        }
    }
    
    var markers = [CrossMarkerView]()

    @IBOutlet var ArrowLabel: [UILabel]!
    
    @IBAction func setArrowPosition(sender: UIPanGestureRecognizer) {
        
        var arrow : Arrow
        
        if arrowTab.count < 6 {
            let location = sender.locationInView(TargetView)
            switch sender.state {
            case .Began:
                arrow = Arrow(id: arrowTab.count, primaryLocation: location)
                arrowTab.append(arrow)
            case .Changed:
                arrowTab.last!.oldLocation = location
                updateUI()
            default:
                break
            }
        }
    }
    
    
    
    //MARK: -UI
    @IBOutlet weak var TargetView: UIImageView! {
        didSet{
            TargetView.image = UIImage(named: "TargetImage")
            TargetView.userInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var CorrectButton: UIButton!{
        didSet {
            CorrectButton.enabled = false
            CorrectButton.addTarget(self, action: #selector(TargetViewController.ButtonAction(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    @IBOutlet weak var SendButton: UIButton!{
        didSet {
            SendButton.enabled = false
            SendButton.addTarget(self, action: #selector(TargetViewController.ButtonAction(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func ButtonAction(sender: UIButton) {
        
        if sender.titleLabel?.text == "Correct" {
            arrowTab.removeLast()
            updateUI()
            
        }
        
        if sender.titleLabel?.text == "Send" {
            performSegueWithIdentifier("targetToResult", sender: self)
        }
    }
    
    func updateUI() {
        var j = 0
        for i in ArrowLabel {
            i.text = ""
            if j < arrowTab.count {
                i.text = String(arrowTab[j].value)
                j += 1
            }
        }
        
        updateMarkers()
    }
    
    func updateMarkers() {
        for i in markers {
            i.removeFromSuperview()
        }
        markers.removeAll()
        for i in arrowTab {
            markers.append(CrossMarkerView(arrow: i))
            TargetView.addSubview(markers.last!)
        }
    }
    
    //MARK: -Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? ResultViewController{
            if let identifier = segue.identifier {
                switch identifier {
                case "targetToResult":
                    dvc.arrowTab = self.arrowTab
                    dvc.targetImage = image
                default:
                    break
                }
            }
        }
    }
    
    //MARK: -Image
    
    var image = UIImage()
    
    @IBAction func takePhot() {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            let picker = UIImagePickerController()
            picker.sourceType = .Camera
            picker.mediaTypes = [kUTTypeImage as String]
            picker.delegate = self
            picker.allowsEditing = true
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var image = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        self.image = image!
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

