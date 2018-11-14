//
//  3dModelSelectViewController.swift
//  test
//
//  Created by Hristiyan Tarnev on 14/06/2018.
//  Copyright © 2018 Hristiyan Tarnev. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class _dModelSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //  let modelArray = [SCNScene(named: "art.scnassets/laptop.scn"), SCNScene(named: "art.scnassets/wooden watch tower2.scn"), SCNScene(named: "art.scnassets/Dragon 2.5_dae.scn")]

    let modelArray = [ UIImage(named: "art.scnassets/spaceship.png"),#imageLiteral(resourceName: "bot"),UIImage(named: "art.scnassets/tower.png")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! ModelCollectionViewCell
        cell.image4.image = modelArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // let desVC = mainStoryboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        // desVC. = modelArray[indexPath.row]!
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let display = modelArray[indexPath.row]!
        // if(cell.image4.image == imageArray[indexPath.row]){}
        if(display == UIImage(named: "art.scnassets/spaceship.png")){
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DragonViewController") as! DragonViewController
            self.navigationController?.pushViewController(nextViewController, animated:true)
        }
        else if(display == UIImage(named: "art.scnassets/tower.png")){
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TowerViewController") as! TowerViewController
            self.navigationController?.pushViewController(nextViewController, animated:true)
        }
        else {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            self.navigationController?.pushViewController(nextViewController, animated:true)
        }
        //display == UIImage(named: "art.scnassets/dragon.png")
        // self.navigationController?.pushViewController(desVC, animated: true)
    }
    
}
