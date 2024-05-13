//
//  NFPosterImageView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 27/02/2024.
//

import UIKit
import SDWebImage

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
    
    func downloadImageFrom(_ endpoint: String){
        guard let url = URL(string: Constants.imageURL + endpoint) else {return}
        sd_imageTransition = .fade
        sd_setImage(with: url, placeholderImage: UIImage(resource: .netflixClone)) {_,error,_,_ in
            if error != nil {
                self.image = UIImage(resource: .netflixClone).withTintColor(.gray)
            }
        }
    }
    
    
    required init?(coder: NSCoder) {fatalError()}
}
