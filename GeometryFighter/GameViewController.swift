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
        spawnShape()
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
        
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
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
    
    func spawnShape()
    {
        var geometry: SCNGeometry
        
        switch ShapeType.random()
        {
            default: geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        }
        
        let geometryNode = SCNNode(geometry: geometry)
        
        scnScene.rootNode.addChildNode(geometryNode)
    }
}
