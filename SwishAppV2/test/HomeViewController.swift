//
//  HomeViewController.swift
//  test
//
//  Created by Kaloyan on 15/06/2018.
//  Copyright © 2018 Hristiyan Tarnev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
      @IBOutlet weak var gallery: UIButton!
    @IBOutlet weak var backgr: UIImageView!
    @IBOutlet var leftSwipe: UISwipeGestureRecognizer!
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    @IBOutlet weak var middleLine: UIImageView!
    @IBOutlet weak var bottomLine: UIImageView!
    
    @IBOutlet var logoSwish: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
        logoSwish.center = view.center
        middleLine.frame.origin.y = 25
        middleLine.frame.origin.x = self.view.frame.width/2 + 5
        bottomLine.frame.origin.y = middleLine.frame.height + 25
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SwipedLeft(_ sender: UISwipeGestureRecognizer) {
        
    }
    @IBAction func SwipedRight(_ sender: UISwipeGestureRecognizer) {
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

