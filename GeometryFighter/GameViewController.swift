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
    var cameraNode : SCNNode!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
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
    
    func setupScene()
    {
        scnScene = SCNScene()
        scnView.scene = scnScene
        
        scnScene.background.contents = "GeometryFighter.scnassets/Textures/Background_Diffuse.jpg"
    }
    
    func setupCamera()
    {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scnScene.rootNode.addChildNode(cameraNode)
    }
}
