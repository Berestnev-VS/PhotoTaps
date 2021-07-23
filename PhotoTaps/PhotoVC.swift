//
//  PhotoVC.swift
//  PhotoTaps
//
//  Created by Владимир on 19.07.2021.
//

import UIKit

class PhotoVC: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var cornerButton: UIButton!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerButton.backgroundColor = .white
        cornerButton.layer.masksToBounds = true
        cornerButton.layer.cornerRadius = 7
        cornerButton.layer.borderColor = UIColor.white.cgColor //закругляем кнопку
        
        
        let someImage = image?.withRoundedCorners(radius: 70)  //закругляем изображение
        photoImageView.image = someImage
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 10
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Successful")
            } else {
                print("The message was not sent")
            }
        }
        present(shareController, animated: true, completion: nil)
    }
    
}

extension UIImage {
        // image with rounded corners
        public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
            let maxRadius = min(size.width, size.height) / 2
            let cornerRadius: CGFloat
            if let radius = radius, radius > 0 && radius <= maxRadius {
                cornerRadius = radius
            } else {
                cornerRadius = maxRadius
            }
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            draw(in: rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }
