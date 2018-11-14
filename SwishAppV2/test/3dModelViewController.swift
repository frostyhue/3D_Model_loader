//
//  3dModelViewController.swift
//  test
//
//  Created by Hristiyan Tarnev on 07/06/2018.
//  Copyright © 2018 Hristiyan Tarnev. All rights reserved.
//

import UIKit
import SceneKit
import QuartzCore

class _dModelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let scene = SCNScene(named: "art.scnassets/Dragon 2.5_dae.scn")
        let cameraMode =  SCNNode()
        cameraMode.camera = SCNCamera()
        scene?.rootNode.addChildNode(cameraMode)
        cameraMode.position = SCNVector3(x:0, y:0, z:15)
        
        let lightmode = SCNNode()
        lightmode.light = SCNLight()
        lightmode.light!.type = .omni
        lightmode.position = SCNVector3(x:0, y:10, z:10)
        scene?.rootNode.addChildNode(lightmode)
        
       _  = scene?.rootNode.childNode
        let scnView = self.view as! SCNView
        
        scnView.scene = scene
        
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.blue
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
    }
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
