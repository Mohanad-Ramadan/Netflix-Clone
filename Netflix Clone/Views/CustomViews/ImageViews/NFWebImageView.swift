//
//  NFPosterImageView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 27/02/2024.
//

import UIKit
import SkeletonView

class NFWebImageView: UIImageView {
    override init(frame: CGRect) {super.init(frame: frame)}
    
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
    }
    
    func downloadImageFrom(_ endpoint: String){
        guard let url = URL(string: Constants.imageURL + endpoint) else {return}
        sd_setImage(with: url)
    }
    
    
    required init?(coder: NSCoder) {fatalError()}
}
