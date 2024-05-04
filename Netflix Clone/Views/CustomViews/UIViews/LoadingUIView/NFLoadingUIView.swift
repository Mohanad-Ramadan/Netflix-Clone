//
//  NFLoadingUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/03/2024.
//

import UIKit

class NFLoadingUIView: UIView {
    override init(frame: CGRect) {super.init(frame: frame)}
    
    convenience init(){
        self.init(frame: .zero)
        layer.cornerRadius = 3
        alpha = 0.5
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    required init?(coder: NSCoder) {fatalError()}
}
