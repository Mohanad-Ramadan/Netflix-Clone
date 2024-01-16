//
//  New&HotTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 07/12/2023.
//

import UIKit
import WebKit

class NewAndHotTableViewCell: UITableViewCell {
    
    static let identifier = "NewAndHotTableViewCell"
    
    var trendingSelected = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        [
            backdropImageView ,remindMeButton ,logoView ,infoButton ,netflixLogo ,entertainmetType ,titleLabel ,overViewLabel ,categoryLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        applyConstraints()
        
        
    }
    
    private let monthlable: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let backdropImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let remindMeButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Remind Me"
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "bell")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        configuration.imagePlacement = .top
        configuration.imagePadding = 8
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 9)
            outgoing.foregroundColor = .gray
            return outgoing
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Info"
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "info.circle")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        configuration.imagePlacement = .top
        configuration.imagePadding = 8
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 9)
            outgoing.foregroundColor = .gray
            return outgoing
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var logoAspectRatio = CGFloat(1)
    
    private let logoView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let entertainmentDate: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let netflixLogo: UIImageView = {
        let image = UIImageView(image: UIImage(named: "netflixClone"))
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let entertainmetType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 8, weight: .semibold)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 3
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "violent.Suspental.action.happpy.korean"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    
    // Month and Day label constraints
    private func setupMonthAndDayLabelConstraints() {
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
    
    // Backdrop image view constraints
    private func setupBackdropImageViewConstraints() {
        if trendingSelected {
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3).isActive = true
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
            backdropImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
        } else {
            backdropImageView.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 10).isActive = true
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
            backdropImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
        }
    }
    
    // Buttons constraints
    private func setupButtonsConstraints() {
        infoButton.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 10).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        remindMeButton.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 10).isActive = true
        remindMeButton.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor).isActive = true
        remindMeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //Logo view
    private func setupLogoViewConstraints() {
        logoView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor,constant: 10).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        logoView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
    }
    
    //Date Label
    private func setupDateLabelConstraints() {
        entertainmentDate.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
        entertainmentDate.topAnchor.constraint(equalTo: remindMeButton.bottomAnchor).isActive = true
        entertainmentDate.heightAnchor.constraint(equalToConstant: 30).isActive = true
        entertainmentDate.widthAnchor.constraint(equalTo: entertainmentDate.widthAnchor).isActive = true
    }
    
    //Type and Logo constraints
    private func setupTypeLabelConstraints() {
        if trendingSelected {
            netflixLogo.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
            netflixLogo.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 10).isActive = true
            netflixLogo.heightAnchor.constraint(equalToConstant: 15).isActive = true
            netflixLogo.widthAnchor.constraint(equalToConstant: 8).isActive = true
        } else {
            netflixLogo.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
            netflixLogo.topAnchor.constraint(equalTo: entertainmentDate.bottomAnchor, constant: 5).isActive = true
            netflixLogo.heightAnchor.constraint(equalToConstant: 15).isActive = true
            netflixLogo.widthAnchor.constraint(equalToConstant: 8).isActive = true
        }
        
        entertainmetType.leadingAnchor.constraint(equalTo: netflixLogo.trailingAnchor, constant: 4).isActive = true
        entertainmetType.centerYAnchor.constraint(equalTo: netflixLogo.centerYAnchor).isActive = true
        entertainmetType.bottomAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        entertainmetType.widthAnchor.constraint(equalTo: entertainmetType.widthAnchor).isActive = true
    }
    
    // Title and overview label constraints
    private func setupTitleOverviewLabelConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: netflixLogo.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: -20).isActive = true
        
        overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        overViewLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -10).isActive = true
        overViewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        overViewLabel.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: -5).isActive = true
    }
    
    // Category label constraints
    private func setupCategoryLabelConstraints() {
        categoryLabel.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 10).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: overViewLabel.leadingAnchor).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        categoryLabel.widthAnchor.constraint(equalTo: categoryLabel.widthAnchor).isActive = true
    }
    
    private func applyConstraints() {
        if trendingSelected {
            setupBackdropImageViewConstraints()
            setupButtonsConstraints()
            setupLogoViewConstraints()
            setupTypeLabelConstraints()
            setupTitleOverviewLabelConstraints()
            setupCategoryLabelConstraints()
        } else {
            addSubview(monthlable)
            addSubview(dayLabel)
            addSubview(entertainmentDate)
            setupMonthAndDayLabelConstraints()
            setupDateLabelConstraints()
            
            setupTypeLabelConstraints()
            setupBackdropImageViewConstraints()
            setupButtonsConstraints()
            setupLogoViewConstraints()
            setupTitleOverviewLabelConstraints()
            setupCategoryLabelConstraints()
        }
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Update logoView Constraints
    private func updateLogoViewConstraints() {
        logoView.removeConstraint(logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: logoAspectRatio))
        let widthConstraint = logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: logoAspectRatio)
        widthConstraint.priority = .defaultHigh
        widthConstraint.isActive = true
        
        layoutIfNeeded()
    }
    
    //MARK: - Get Cell Details
    func configureCellImages(with model: MovieViewModel){
        if let backdrop = model.backdropsPath ,let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500/\(backdrop)"){
            backdropImageView.sd_setImage(with: backdropURL)
        }
        
        if let logo = model.logoPath, let logoURL = URL(string: "https://image.tmdb.org/t/p/w500\(logo)"){
            logoView.sd_setImage(with: logoURL)
        }
        
        if let logoAspectRatio = model.logoAspectRatio {
            self.logoAspectRatio = logoAspectRatio > 4 ? 4 : logoAspectRatio
            updateLogoViewConstraints()
        }
    }
    
    func configureCellDetails(with model: MovieViewModel){
        titleLabel.text = model.title
        entertainmetType.text = model.mediaType == "movie" ? "F I L M" : "S E R I E S"
        overViewLabel.text = model.overview
        categoryLabel.text = model.category
        
        if let date = model.date {
            let dayMonthDate = date.extractMonthAndDay().dayMonth
            entertainmentDate.text = dayMonthDate.whenItBeLiveText(modelFullDate: date)
            dayLabel.text = date.extractMonthAndDay().day
            monthlable.text = date.extractMonthAndDay().month
        }
    }
    
}

