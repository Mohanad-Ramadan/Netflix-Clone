//
//  EveryonesTableCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 06/04/2024.
//

import UIKit

class EveryonesTableCell: NewHotTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [backdropImageView ,logoView ,netflixLogo ,mediaTypeLabel ,titleLabel ,overViewLabel ,genresLabel ].forEach { contentView.addSubview($0) }
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        setupBackdropImageViewConstraints()
        setupButtonsConstraints()
        setupLogoViewConstraints()
        setupNetflixLogoConstraints(bottomTo: logoView)
        setupTypeLabelConstraints()
        setupTitleOverviewLabelConstraints()
        setupCategoryLabelConstraints()
    }
    
    static let identifier = "EveryonesTableCell"
    
    required init?(coder: NSCoder) {fatalError()}
}

