//
//  NFPlainButton.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 29/02/2024.
//

import UIKit
import SDWebImage

class NFPlainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Plain button with white title, clear background with optional image
    convenience init(title: String, titleColor: UIColor = .white, image: UIImage? = nil, imagePlacement: NSDirectionalRectEdge = .leading, imagePadding: CGFloat = 8, fontSize: CGFloat, fontWeight: UIFont.Weight,fontColorOnly: UIColor? = nil){
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
    
    
    /// Bar button with white title, clear background, gray stroke and optional image
    convenience init(barButtontitle title: String, image: UIImage? = nil ,fontColorOnly: UIColor? = nil){
        self.init(frame: .zero)
         
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.baseForegroundColor = .white
        configuration.image = image
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.cornerStyle = .capsule
        configuration.background.strokeWidth = 1
        configuration.background.strokeColor = UIColor(red: 186/255.0, green: 190/255.0, blue: 197/255.0, alpha: 0.5)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 14, weight: .bold)
            return outgoing
        }
        
        self.configuration = configuration
    }
    
    func configureButtonImageWith(_ image: UIImage, tinted: UIColor? = nil , width: CGFloat, height: CGFloat, placement: NSDirectionalRectEdge, padding: CGFloat) {
        
        if tinted != nil {
            configuration?.image = image.sd_resizedImage(with: CGSize(width: width, height: height), scaleMode: .aspectFit)?.withTintColor(tinted!)
        } else {
            configuration?.image = image.sd_resizedImage(with: CGSize(width: width, height: height), scaleMode: .aspectFit)
        }
        configuration?.imagePlacement = placement
        configuration?.imagePadding = padding
    }
    
    
    required init?(coder: NSCoder) {fatalError()}
}
