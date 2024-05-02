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
    
    override func configureCellDetails(with media: MediaViewModel) {
        
        titleLabel.text = media.title
        entertainmetType.text = media.mediaType == "tv" ? "S E R I E S" : "F I L M"
        overViewLabel.text = media.overview
        genresLabel.text = media.category
        
        if let date = media.releaseDate {
            let dayMonthDate = date.extract().dayMonth
            mediaDate.text = dayMonthDate.whenItBeLiveText(modelFullDate: date)
            dayLabel.text = date.extract().day
            monthlable.text = date.extract().month
        }
    }
    
    //Month and Day label constraints
     func setupMonthAndDayLabelConstraints() {
        // Day label constraints
        monthlable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        monthlable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        monthlable.heightAnchor.constraint(equalToConstant: 25).isActive = true
        monthlable.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Day label constraints
        dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        dayLabel.topAnchor.constraint(equalTo: monthlable.bottomAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }

    //Date Label
     func setupDateLabelConstraints() {
        mediaDate.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
        mediaDate.topAnchor.constraint(equalTo: remindMeButton.bottomAnchor).isActive = true
        mediaDate.heightAnchor.constraint(equalToConstant: 30).isActive = true
        mediaDate.widthAnchor.constraint(equalTo: mediaDate.widthAnchor).isActive = true
    }
    
    
    private func applyConstraints() {
        setupMonthAndDayLabelConstraints()
        setupBackdropImageViewConstraints(dayLabel: dayLabel)
        setupDateLabelConstraints()
        setupNetflixLogoConstraints(bottomTo: mediaDate)
        setupTypeLabelConstraints()
        setupButtonsConstraints()
        setupLogoViewConstraints()
        setupTitleOverviewLabelConstraints()
        setupCategoryLabelConstraints()
    }
    
    let monthlable = NFBodyLabel(color: .lightGray, fontSize: 16, fontWeight: .semibold, textAlignment: .center)
    let dayLabel = NFBodyLabel(fontSize: 26, fontWeight: .bold, textAlignment: .center)
    let mediaDate = NFBodyLabel(color: .white, fontSize: 16, textAlignment: .left)
    
    static let identifierComing = "ComingSoonTableCell"
    
    required init?(coder: NSCoder) {fatalError()}
}
