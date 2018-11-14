//
//  ViewController.swift
//  PhotoEditing
//
//  Created by issd on 07/06/2018.
//  Copyright © 2018 issd. All rights reserved.
//

import UIKit

class TextureView: UIViewController {
    
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var btClear: UIButton!
    @IBOutlet weak var canvas: DrawView!
    
    public var imageToDrawOn: UIImage!
    public var thingToDrawOn: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.clipsToBounds = true
        canvas.isMultipleTouchEnabled = false
        canvas.backgroundColor = UIColor(patternImage: imageToDrawOn)
        
    }
    
    @IBAction func Save() {
        canvas.screenshot()
    }
    @IBAction func Clear() {
        canvas.clear()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination as? GameViewController
        canvas.screenshot()
        
        if(thingToDrawOn.contains("bottle")){
            destination?.bottleTextureImage = canvas.savedImage
            } else {
            destination?.capTextureImage = canvas.savedImage
        }
        
    }
}
