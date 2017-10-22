//
//  GameViewController.swift
//  GeometryFighter
//
//  Created by Mick M on 21/10/2017.
//  Copyright © 2017 Mick M. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController
{
    var scnView : SCNView!
    var scnScene : SCNScene!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool
    {
        return true
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func setupView()
    {
        scnView = self.view as! SCNView
    }
}
