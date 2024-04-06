//
//  ComingSoonTableCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 06/04/2024.
//

import UIKit

class ComingSoonTableCell: NewHotTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [monthlable ,dayLabel ,mediaDate ,backdropImageView ,remindMeButton ,logoView ,infoButton ,netflixLogo ,entertainmetType ,titleLabel ,overViewLabel ,genresLabel ].forEach { contentView.addSubview($0) }
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        setupMonthAndDayLabelConstraints()
        setupBackdropImageViewConstraints(comingSoonCell: true)
        setupDateLabelConstraints()
        setupNetflixLogoConstraints(bottomTo: mediaDate)
        setupTypeLabelConstraints()
        setupButtonsConstraints()
        setupLogoViewConstraints()
        setupTitleOverviewLabelConstraints()
        setupCategoryLabelConstraints()
    }
    
    static let identifierComing = "ComingSoonTableCell"
    
    required init?(coder: NSCoder) {fatalError()}
}
