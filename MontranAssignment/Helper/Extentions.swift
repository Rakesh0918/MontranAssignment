//
//  Extentions.swift
//  MontranAssignment
//
//  Created by Rakesh Sharma on 20/04/24.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

extension UIImageView {
    func loadImage(imageUrl: String) {
        Task {
            if let downloadedImage = await APIManager.downloadImage(from: imageUrl) {
                image = downloadedImage
            } else {
                
            }
        }
    }
}
