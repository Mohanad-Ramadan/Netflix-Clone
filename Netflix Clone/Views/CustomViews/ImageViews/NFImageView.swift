//
//  NFImageView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 27/02/2024.
//

import UIKit

class NFImageView: UIImageView {
    override init(frame: CGRect) {super.init(frame: frame)}
    
    convenience init(image: ImageResource, cornerRadius: CGFloat = 0, contentMode: ContentMode = .scaleAspectFill, autoLayout: Bool = false ){
        self.init(frame: .zero)
        self.image = UIImage(resource: image)
        self.contentMode = contentMode
        layer.cornerRadius = cornerRadius
        
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = autoLayout
    }
    
    required init?(coder: NSCoder) {fatalError()}
}
