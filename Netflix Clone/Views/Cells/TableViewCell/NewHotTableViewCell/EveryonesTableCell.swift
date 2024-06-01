//
//  EveryonesTableCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 06/04/2024.
//

import UIKit

class EveryonesTableCell: NewHotTableViewCell {
    
    static let identifier = "EveryonesTableCell"
    
    //MARK: - Load View
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [
            backdropImageView ,
            logoView ,
            netflixLogo ,
            mediaTypeLabel ,
            titleLabel ,
            overViewLabel ,
            genresLabel
        ].forEach { contentView.addSubview($0) }
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    //MARK: - Constraints
    private func applyConstraints() {
        setupBackdropImageViewConstraints()
        setupButtonsConstraints(for: shareButton, myListButton, playButton)
        setupLogoViewConstraints()
        setupNetflixLogoConstraints(bottomTo: logoView)
        setupTypeLabelConstraints()
        setupTitleOverviewLabelConstraints()
        setupCategoryLabelConstraints()
    }
    
}

