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
    var nbrsEnd : Int! {
        didSet{
            print("numero de la volée : \(nbrsEnd)")
        }
    }
    
    var nbrsArrow : Int! {
        didSet{
            for i in 0...nbrsArrow-1 {
                arrowTab.append(Arrow(id: i))
            }
        }
    }
    
    var arrowTab = [Arrow]() 
    
    var markers = [CrossMarkerView]()

    @IBOutlet var ArrowLabel: [UILabel]!
    
    var arrowId : Int = 0
    
    @IBAction func setArrowPosition(sender: UIPanGestureRecognizer) {
        
        if arrowId < nbrsArrow {
            let location = sender.locationInView(TargetView)
            let currentArrow = arrowTab[arrowId]
            switch sender.state {
            case .Began:
                currentArrow.shots.append(Shot(location: location))
            case .Changed:
                currentArrow.shots.last?.location = location
            case .Ended:
                arrowId += 1
            default:
                break
            }
            
            updateUI()
        }

    }
    
    
    
    //MARK: -UI
    @IBOutlet weak var TargetView: UIImageView!
    
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
            arrowTab[arrowId-1].shots.removeLast()
            arrowId -= 1
            updateUI()
        }
        
        if sender.titleLabel?.text == "Send" {
            performSegueWithIdentifier("targetToResult", sender: self)
        }
    }
    
    func updateUI() {
        
        for i in 0...nbrsArrow-1 {
            ArrowLabel[i].text = ""
            let shots = arrowTab[i].shots
            if shots.count == nbrsEnd+1 {
                ArrowLabel[i].text = String(shots[nbrsEnd].value)
            }
        }
        
        var completedEnd : Bool = false
        var isAnyArrowShot : Bool = false
        for arrow in arrowTab {
            if  arrow.shots.count != nbrsEnd + 1 {
                completedEnd = false
                break
            }
            completedEnd = true
        }
        for arrow in arrowTab {
            if arrow.shots.count == nbrsEnd + 1 {
                isAnyArrowShot = true
                break
            }
        }
        
        if completedEnd { SendButton.enabled = true } else { SendButton.enabled = false }
        if isAnyArrowShot { CorrectButton.enabled = true } else { CorrectButton.enabled = false }
        
        
        updateMarkers()
    }
    
    func updateMarkers() {
        for i in markers {
            i.removeFromSuperview()
        }
        markers.removeAll()
        
        for arrow in arrowTab {
            if arrow.shots.count == nbrsEnd+1 {
                
                let shot = arrow.shots[nbrsEnd]
                
                markers.append(CrossMarkerView(shot: shot, frame: TargetView.bounds))
                
                TargetView.addSubview(markers.last!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        updateUI()
        super.viewWillAppear(animated)
    }
    
    //MARK: -Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? UINavigationController{
            if let identifier = segue.identifier {
                switch identifier {
                case "targetToResult":
                    let nvc = dvc.topViewController as! ResultViewController
                    nvc.arrowTab = self.arrowTab
                    nvc.nbrsEnd = self.nbrsEnd
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

