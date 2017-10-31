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
    var spawnTime : TimeInterval = 0
    var game = GameHelper.sharedInstance
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        setupHUD()
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
        scnView.delegate = self
        scnView.isPlaying = true
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
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape()
    {
        var geometry: SCNGeometry
        
        switch ShapeType.random()
        {
            case ShapeType.sphere:
                geometry = SCNSphere(radius: 1.0)
            case ShapeType.pyramid:
                geometry = SCNPyramid(width: 1.5, height: 1.5, length: 1.5)
            case ShapeType.torus:
                geometry = SCNTorus(ringRadius: 1.0, pipeRadius: 0.5)
            case ShapeType.capsule:
                geometry = SCNCapsule(capRadius: 1.0, height: 1.0)
            case ShapeType.cylinder:
                geometry = SCNCylinder(radius: 0.7, height: 0.9)
            case ShapeType.cone:
                geometry = SCNCone(topRadius: 0.0, bottomRadius: 1.5, height: 1.0)
            case ShapeType.tube:
                geometry = SCNTube(innerRadius: 0.5, outerRadius: 1.0, height: 1.0)
            default: geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        }
        
        let geometryNode = SCNNode(geometry: geometry)
        
        let color = UIColor.random()
        geometry.materials.first?.diffuse.contents = color
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        let trailEmitter = createTrail(color: color, geometry: geometry)
        geometryNode.addParticleSystem(trailEmitter)
        
        let randomX = Float.random(min: -2, max: 2)
        let randomY = Float.random(min: 10, max: 18)
        
        let force = SCNVector3(x: randomX, y: randomY , z: 0)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        scnScene.rootNode.addChildNode(geometryNode)
    }
    
    func cleanScene()
    {
        for node in scnScene.rootNode.childNodes
        {
           if node.presentation.position.y < -2
           {
                node.removeFromParentNode()
            }
        }
    }
    
    func createTrail(color: UIColor, geometry: SCNGeometry) -> SCNParticleSystem
    {
        let trail = SCNParticleSystem(named: "Trail.scnp", inDirectory: nil)!
        trail.particleColor = color
        trail.emitterShape = geometry
        return trail
    }
    
    func setupHUD()
    {
        game.hudNode.position = SCNVector3(x: 0.0, y: 10.0, z: 0.0)
        scnScene.rootNode.addChildNode(game.hudNode)
    }
}

extension GameViewController: SCNSceneRendererDelegate
{
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        if time > spawnTime
        {
            spawnShape()
            spawnTime = time + TimeInterval(Float.random(min: 0.2, max: 1.5))
            game.updateHUD()
        }
        cleanScene()
    }
}

