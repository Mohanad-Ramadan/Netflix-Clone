//
//  NFTitleLabel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 28/02/2024.
//

import UIKit

class NFTitleLabel: UILabel {
    override init(frame: CGRect) {super.init(frame: frame)}
    
    convenience init(text: String, color: UIColor = .white, textAlignment: NSTextAlignment = .left, lines: Int = 0, autoLayout: Bool = true){
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        textColor = color
        font = .boldSystemFont(ofSize: 26)
        numberOfLines = lines
        
        translatesAutoresizingMaskIntoConstraints = autoLayout
    }
    
    
    required init?(coder: NSCoder) {fatalError()}
}
