//
//  NFPlainButton.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 29/02/2024.
//

import UIKit

class NFPlainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Plain button with white title, clear background with optional image
    convenience init(title: String, titleColor: UIColor = .white, image: UIImage? = nil, imagePlacement: NSDirectionalRectEdge = .leading, imagePadding: CGFloat = 8, fontSize: CGFloat, fontWeight: UIFont.Weight,fontColorOnly: UIColor? = nil, withSmallCorner corner: Bool = false ){
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
            outgoing.foregroundColor = fontColorOnly
            return outgoing
        }
        
        self.configuration = configuration
    }
    
    
    
    required init?(coder: NSCoder) {fatalError()}
}
