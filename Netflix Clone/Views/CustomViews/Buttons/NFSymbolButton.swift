//
//  NFSymbolButton.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 29/02/2024.
//

import UIKit

class NFSymbolButton: UIButton {
    override init(frame: CGRect) {super.init(frame: frame)}
    
    /// Symbol button with defualt white color
    convenience init(imageName: String, imageSize: CGFloat, imageColor: UIColor = .white){
        self.init(frame: .zero)
        
        let image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize))
        setImage(image, for: .normal)
        tintColor = imageColor
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    required init?(coder: NSCoder) {fatalError()}
}
