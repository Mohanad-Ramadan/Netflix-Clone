//
//  NFBodyLabel.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 28/02/2024.
//

import UIKit

class NFBodyLabel: UILabel {
    override init(frame: CGRect) {super.init(frame: frame)}
    
    convenience init(text: String = "",color: UIColor = .white, fontSize: CGFloat, fontWeight: UIFont.Weight = .regular, textAlignment: NSTextAlignment = .left, lines: Int = 1){
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        textColor = color
        font = .systemFont(ofSize: fontSize, weight: fontWeight)
        numberOfLines = lines
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    required init?(coder: NSCoder) {fatalError()}
}
