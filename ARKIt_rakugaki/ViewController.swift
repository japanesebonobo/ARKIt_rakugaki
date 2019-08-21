//
//  ViewController.swift
//  ARKIt_rakugaki
//
//  Created by 吉冨優太 on 2019/08/21.
//  Copyright © 2019 吉冨優太. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    let defaultConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        return configuration
    }()
    
    var drawingNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Run the view's session
        sceneView.session.run(defaultConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let lineNode = createBallLine()
        lineNode.scale = SCNVector3(0.1, 0.1, 0.1)
        
        //スクリーン座標系
        guard let location: CGPoint = touches.first?.location(in: sceneView) else {
            return
        }
        let pos: SCNVector3 = SCNVector3(location.x, location.y, 0.996)
        
        //ワールド座標系
        let finalPosition = sceneView.unprojectPoint(pos)
        
        lineNode.position = finalPosition
        sceneView.scene.rootNode.addChildNode(lineNode)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let node: SCNNode
      
        if let drawingNode = drawingNode {
            node = drawingNode.clone()
        } else {
            node = createBallLine()
            drawingNode = node
        }
        
        //スクリーン座標系
        guard let location: CGPoint = touches.first?.location(in: sceneView) else {
            return
        }
        let pos: SCNVector3 = SCNVector3(location.x, location.y, 0.996)
        
        //ワールド座標系
        let finalPosition = sceneView.unprojectPoint(pos)
        
        node.position = finalPosition
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    private func createBallLine() -> SCNNode {
        let ball = SCNSphere(radius: 0.005)
        
        let node = SCNNode(geometry: ball)
        return node
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
}
