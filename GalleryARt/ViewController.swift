//
//  ViewController.swift
//  GalleryARt
//
//  Created by Ayoola John on 10/4/19.
//  Copyright © 2019 Astro Media Lab. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit


struct ImageInformation {
    let name: String
    let description: String
    let image: UIImage
}

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    var selectedImage : ImageInformation?
    
    let images = ["inevitable" : ImageInformation(name: "Inevitable Human", description: "The Mona Lisa is a half-length portrait painting by the Italian Renaissance artist Leonardo da Vinci that has been described as 'the best known, the most visited, the most written about, the most sung about, the most parodied work of art in the world'.", image: UIImage(named: "inevitable")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    
        // Get a reference to the images in the AR resource group
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "photogallery" , bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Add reference images to the ARWorldTrackingConfiguration
        configuration.detectionImages = referenceImages

        // Run the view's session
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        
        if let imageAnchor = anchor as? ARImageAnchor,
            let referenceImageName = imageAnchor.referenceImage.name,
            let scannedImage = self.images[referenceImageName] {
            
            self.selectedImage = scannedImage
            
            self.performSegue(withIdentifier: "ShowImageInformation", sender: self)
            
            return imageSeenMarker()
        }
        
        return nil

    }
    
    
    
    // Create and configure a node for the anchor added to the view's session.
    private func imageSeenMarker() -> SKLabelNode {
        let labelNode = SKLabelNode(text: "✅")
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageInformation"{
            if let imageInformationVC = segue.destination as? ImageInformationViewController,
                let actualSelectedImage = selectedImage {
                imageInformationVC.imageInformation = actualSelectedImage
            }
        }
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
