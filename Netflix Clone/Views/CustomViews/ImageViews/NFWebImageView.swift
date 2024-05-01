//
//  NFPosterImageView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 27/02/2024.
//

import UIKit
import SkeletonView

class NFWebImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
    }
    
    convenience init(
        cornerRadius: CGFloat = 0,
        contentMode: ContentMode = .scaleAspectFill,
        autoLayout: Bool = true,
        enableSkeleton: Bool = true
    ){
        self.init(frame: .zero)
        layer.cornerRadius = cornerRadius
        self.contentMode = contentMode
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = autoLayout
        if enableSkeleton {showAnimatedSkeleton()}
    }
    
    func downloadImageFrom(_ endpoint: String){
        guard let url = URL(string: Constants.imageURL + endpoint) else {return}
        sd_setImage(with: url) {_,_,_,_ in 
            self.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }
    
    
    required init?(coder: NSCoder) {fatalError()}
}
