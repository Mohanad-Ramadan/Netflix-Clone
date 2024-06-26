//
//  NFFilledButton.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 28/02/2024.
//

import UIKit
import SDWebImage

class NFFilledButton: UIButton {
    override init(frame: CGRect) {super.init(frame: frame)}
    
    /// Filled button with black title, white background and optional Image
    convenience init(title: String, foregroundColor: UIColor = .black, backgroundColor: UIColor = .white, image: UIImage? = nil, imagePlacement: NSDirectionalRectEdge = .leading, imagePadding: CGFloat = 8, fontSize: CGFloat, fontWeight: UIFont.Weight, cornerStyle: UIButton.Configuration.CornerStyle = .small, autoLayout: Bool = false){
        self.init(frame: .zero)
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = backgroundColor
        configuration.baseForegroundColor = foregroundColor
        configuration.image = image
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        configuration.imagePlacement = imagePlacement
        configuration.imagePadding = imagePadding
        configuration.cornerStyle = cornerStyle
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: fontSize, weight: fontWeight)
            return outgoing
        }
        
        self.configuration = configuration
        translatesAutoresizingMaskIntoConstraints = autoLayout
    }
    
    
    // Custom setups for button image
    func configureButtonImageWith(_ image: UIImage, tinted: UIColor? = nil , width: CGFloat, height: CGFloat, placement: NSDirectionalRectEdge, padding: CGFloat) {
        
        if let tinted {
            configuration?.image = image.sd_resizedImage(with: CGSize(width: width, height: height), scaleMode: .aspectFit)?.withTintColor(tinted)
        } else {
            configuration?.image = image.sd_resizedImage(with: CGSize(width: width, height: height), scaleMode: .aspectFit)
        }
        configuration?.imagePlacement = placement
        configuration?.imagePadding = padding
    }
    
    
    required init?(coder: NSCoder) {fatalError()}
}
