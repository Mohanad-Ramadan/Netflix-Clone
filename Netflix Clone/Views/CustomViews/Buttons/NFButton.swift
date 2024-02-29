//
//  NFButton.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 28/02/2024.
//

import UIKit

class NFButton: UIButton {
    override init(frame: CGRect) { 
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Button filled white with optional Image
    convenience init(filledButtonTitle title: String, fillColor: UIColor = .white, image: UIImage? = nil, imagePlacement: NSDirectionalRectEdge = .leading, imagePadding: CGFloat = 8, fontSize: CGFloat, fontWeight: UIFont.Weight, withSmallCorner corner: Bool = false ){
        self.init(frame: .zero)
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.image = image
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        configuration.imagePlacement = imagePlacement
        configuration.imagePadding = imagePadding
        configuration.cornerStyle = corner ? .small : .fixed
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: fontSize, weight: fontWeight)
            return outgoing
        }
        
        self.configuration = configuration
    }
    
    /// Clear plain button with optional image
    convenience init(plainButtonTitle title: String, titleColor: UIColor = .white, image: UIImage? = nil, imagePlacement: NSDirectionalRectEdge = .leading, imagePadding: CGFloat = 8, fontSize: CGFloat, fontWeight: UIFont.Weight, withSmallCorner corner: Bool = false ){
        self.init(frame: .zero)
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.baseForegroundColor = titleColor
        configuration.image = image
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        configuration.imagePlacement = imagePlacement
        configuration.imagePadding = imagePadding
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: fontSize, weight: fontWeight)
            return outgoing
        }
        
        self.configuration = configuration
    }
    
    
    
    required init?(coder: NSCoder) {fatalError()}
}
