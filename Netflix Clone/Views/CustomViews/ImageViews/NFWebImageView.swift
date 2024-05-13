//
//  NFPosterImageView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 27/02/2024.
//

import UIKit
import SDWebImage

enum ImageExtendVector { case vertical, horizontal }

class NFWebImageView: UIImageView {
    override init(frame: CGRect) {super.init(frame: frame)}
    
    convenience init(
        cornerRadius: CGFloat = 0,
        contentMode: ContentMode = .scaleAspectFill,
        autoLayout: Bool = true
    ){
        self.init(frame: .zero)
        layer.cornerRadius = cornerRadius
        self.contentMode = contentMode
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = autoLayout
    }
    
    func downloadImage(from endpoint: String, extendVector: ImageExtendVector){
        guard let url = URL(string: Constants.imageURL + endpoint) else {return}
        sd_imageTransition = .fade
        
        switch extendVector {
        case .vertical: sd_setImage(with: url, placeholderImage: verticalPlaceholder)
        case .horizontal: sd_setImage(with: url, placeholderImage: horizontalPlaceholder)
        }
        
    }
    
    let verticalPlaceholder: UIImage = UIImage(resource: .netflixIcon)
    let horizontalPlaceholder: UIImage = UIImage(resource: .netflixLogo)
    
    
    required init?(coder: NSCoder) {fatalError()}
}
