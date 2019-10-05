//
//  ImageInformationViewController.swift
//  GalleryARt
//
//  Created by Ayoola John on 10/4/19.
//  Copyright © 2019 Astro Media Lab. All rights reserved.
//

import UIKit


class ImageInformationViewController : UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    
    var imageInformation : ImageInformation?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let actualImageInformation = imageInformation {
            self.nameLabel.text = actualImageInformation.name
            self.imageView.image = actualImageInformation.image
            self.descriptionText.text = actualImageInformation.description
        }
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
        
    }
    
    
}
