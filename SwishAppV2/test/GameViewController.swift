//
//  GameViewController.swift
//  test
//
//  Created by Hristiyan Tarnev on 31/05/2018.
//  Copyright © 2018 Hristiyan Tarnev. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    public var bottleTextureImage: UIImage!
    public var capTextureImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()
        
        let tempScene = SCNScene(named:"art.scnassets/bottle.dae")
        
        
        var tempNode = tempScene?.rootNode.childNode(withName: "Bottle_low", recursively: true)
        
        
        if (bottleTextureImage == nil){
            let img = UIImage(named: "Bottle_albedo")
            
            bottleTextureImage =  self.getImageWithColor(color: UIColor.yellow, size: (img?.size)!)
        }
        
        tempNode?.geometry?.firstMaterial?.diffuse.contents = bottleTextureImage

        tempNode?.geometry?.firstMaterial?.normal.contents = UIImage(named: "Bottle_normal")
        tempNode?.geometry?.firstMaterial?.emission.contents = UIImage(named: "Bottle_metallic")
        tempNode?.geometry?.firstMaterial?.specular.contents = UIImage(named: "Bottle_roughness")
        tempNode?.geometry?.firstMaterial?.multiply.contents = UIImage(named: "Bottle_AO")
        
        
        scene.rootNode.addChildNode(tempNode!)
        
        tempNode = tempScene?.rootNode.childNode(withName: "Cap_low", recursively: true)
        
        if (capTextureImage == nil){
            let img = UIImage(named: "Cap_albedo")
            
            capTextureImage =  self.getImageWithColor(color: UIColor.gray, size: (img?.size)!)
        }
        
        tempNode?.geometry?.firstMaterial?.diffuse.contents = capTextureImage
        tempNode?.geometry?.firstMaterial?.normal.contents = UIImage(named: "Cap_normal")
        //tempNode?.geometry?.firstMaterial?.emission.contents = UIImage(named: "Cap_metallic")
        tempNode?.geometry?.firstMaterial?.specular.contents = UIImage(named: "Cap_roughness")
        tempNode?.geometry?.firstMaterial?.multiply.contents = UIImage(named: "Cap_AO")
        
        
        scene.rootNode.addChildNode(tempNode!)

        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        //let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
       
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
       
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
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
            
            material.emission.contents = UIColor.purple
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? TextureView
        
        print(segue.identifier!)
        
        if segue.identifier! == "body"{
            destination?.imageToDrawOn = bottleTextureImage
            destination?.thingToDrawOn = "bottle"
        } else {
            destination?.thingToDrawOn = "cap"
            destination?.imageToDrawOn = capTextureImage
        }
    }

}
