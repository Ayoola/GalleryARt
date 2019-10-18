//
//  ViewController.swift
//  GalleryARt
//
//  Created by Ayoola John on 10/4/19.
//  Copyright © 2019 Astro Media Lab. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    // Primary SceneKit view that renders the AR session
    @IBOutlet var sceneView: ARSCNView!
    
    // A serial queue for thread safety when modifyinf SceneKit's scene graph
    let updateQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).serialSCNQueue")
    
    // MARK: - Lifecycle
    
    // Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // add statistics such as FPS and timing information (for development purposes)
        sceneView.showsStatistics = true
    
        // Enable environment-based lighting
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
    }
    
    // Notifies the view controller that its view is about to be added to a view hierarchy
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get a reference to the images in the AR resource group
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "ARgallery" , bundle: Bundle.main) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        // Add reference images to the ARWorldTrackingConfiguration
        configuration.trackingImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1

        // Run the view's session
        sceneView.session.run(configuration, options: ARSession.RunOptions(arrayLiteral: [.resetTracking, .removeExistingAnchors]))
    }
    
    // Notifies the view controller that its about to be removed from a view hierarchy
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
}
