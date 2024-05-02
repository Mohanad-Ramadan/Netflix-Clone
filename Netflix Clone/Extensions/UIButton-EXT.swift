//
//  UIButton-EXT.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 02/05/2024.
//

import UIKit

extension UIButton {
    // animate the image or the
    func animateButtonWith(title: String, image: UIImage, width: CGFloat = 25, height: CGFloat = 25) {
        UIView.animate() {
            configuration?.title = ""
            configuration?.image = image.sd_resizedImage(with: CGSize(width: width, height: width), scaleMode: .aspectFit)
        } completion: { finished in
            UIView.animate(options: .transitionCrossDissolve) {
                self.configuration?.title = title
            }
        }
    }
    
    
}
