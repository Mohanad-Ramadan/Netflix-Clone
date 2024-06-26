//
//  ComingSoonTableCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 06/04/2024.
//

import UIKit

class ComingSoonTableCell: NewHotTableViewCell {
    
    //MARK: Declare Variables
    let monthlable = NFBodyLabel(color: .lightGray, fontSize: 16, fontWeight: .semibold, textAlignment: .center)
    let dayLabel = NFBodyLabel(fontSize: 26, fontWeight: .bold, textAlignment: .center)
    let countDownDate = NFBodyLabel(color: .white, fontSize: 16, textAlignment: .left)
    
    static let identifier = "ComingSoonTableCell"
    
    //MARK: - Load View
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [
            monthlable ,
            dayLabel ,
            countDownDate ,
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
    
    //MARK: - Setup View
    override func configureCellDetails(with details: DetailsViewModel) {
        titleLabel.text = details.title
        mediaTypeLabel.text = details.mediaTypeLabel
        overViewLabel.text = details.overview
        genresLabel.text = details.genres
        // setup date labels
        countDownDate.text = details.dateCountDownText
        dayLabel.text = details.releaseDay
        monthlable.text = details.releaseMonth
    }
    
    
    //MARK: - Constraints
    
    //Month and Day label constraints
    private func setupMonthAndDayLabelConstraints() {
        // Day label constraints
        monthlable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        monthlable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        monthlable.heightAnchor.constraint(equalToConstant: 25).isActive = true
        monthlable.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Day label constraints
        dayLabel.adjustsFontSizeToFitWidth   = true
        dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        dayLabel.topAnchor.constraint(equalTo: monthlable.bottomAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }

    //Date Label
    private func setupDateLabelConstraints() {
        countDownDate.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
        countDownDate.topAnchor.constraint(equalTo: remindMeButton.bottomAnchor).isActive = true
        countDownDate.heightAnchor.constraint(equalToConstant: 30).isActive = true
        countDownDate.widthAnchor.constraint(equalTo: countDownDate.widthAnchor).isActive = true
    }
    
    
    private func applyConstraints() {
        setupBackdropImageViewConstraints(dayLabel: dayLabel)
        setupNetflixLogoConstraints(bottomTo: countDownDate)
        setupButtonsConstraints(for: remindMeButton, infoButton)
        setupMonthAndDayLabelConstraints()
        setupDateLabelConstraints()
        
        setupTypeLabelConstraints()
        setupLogoViewConstraints()
        setupTitleOverviewLabelConstraints()
        setupCategoryLabelConstraints()
    }
}
