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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        [
            monthlable ,dayLabel ,backdropImageView ,remindMeButton ,logoView  ,infoButton ,entertainmentDate ,netflixLogo ,entertainmetType ,titleLabel ,overViewLabel ,categoryLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        applyConstraints()
        
        
    }
    
    private let monthlable: UILabel = {
        let label = UILabel()
        label.text = "MAR"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
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
        label.text = "Coming on 30 March"
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
        label.text = "Title Lable"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting definesPresentationContext to true indicates that the view controller's view should provide the presentation context for view controllers it presents."
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
    
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            
            //Datelabel
            monthlable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            monthlable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            monthlable.heightAnchor.constraint(equalToConstant: 25),
            monthlable.widthAnchor.constraint(equalToConstant: 40),
            
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dayLabel.topAnchor.constraint(equalTo: monthlable.bottomAnchor),
            dayLabel.heightAnchor.constraint(equalToConstant: 30),
            dayLabel.widthAnchor.constraint(equalToConstant: 40),
            
            //Poster ImageView
            backdropImageView.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 10),
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            backdropImageView.heightAnchor.constraint(equalToConstant: 200),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            
            //Buttons
            infoButton.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 10),
            infoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            infoButton.heightAnchor.constraint(equalToConstant: 50),
            
            remindMeButton.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 10),
            remindMeButton.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor),
            remindMeButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            //Logo view
            logoView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor,constant: 10),
            logoView.heightAnchor.constraint(equalToConstant: 45),
            logoView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
            
            
            //DateLabel
            entertainmentDate.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
            entertainmentDate.topAnchor.constraint(equalTo: remindMeButton.bottomAnchor),
            entertainmentDate.heightAnchor.constraint(equalToConstant: 30),
            entertainmentDate.widthAnchor.constraint(equalTo: entertainmentDate.widthAnchor),
            
            //Type label
            netflixLogo.leadingAnchor.constraint(equalTo: entertainmentDate.leadingAnchor),
            netflixLogo.centerYAnchor.constraint(equalTo: entertainmetType.centerYAnchor),
            netflixLogo.heightAnchor.constraint(equalToConstant: 15),
            netflixLogo.widthAnchor.constraint(equalToConstant: 8),
            
            entertainmetType.leadingAnchor.constraint(equalTo: netflixLogo.trailingAnchor, constant: 4),
            entertainmetType.topAnchor.constraint(equalTo: entertainmentDate.bottomAnchor, constant: 6),
            entertainmetType.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            entertainmetType.widthAnchor.constraint(equalTo: entertainmetType.widthAnchor),
            
            //Title
            titleLabel.leadingAnchor.constraint(equalTo: entertainmentDate.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: netflixLogo.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: -20),
            
            //Overview
            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overViewLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -10),
            overViewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            //Category
            categoryLabel.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: overViewLabel.leadingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 15),
            categoryLabel.widthAnchor.constraint(equalTo: categoryLabel.widthAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Get Cell Details
    
    private func updateLogoViewConstraints() {
        logoView.removeConstraint(logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: logoAspectRatio))
        
        let widthConstraint = logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: logoAspectRatio)
        widthConstraint.priority = .defaultHigh
        widthConstraint.isActive = true
        
        layoutIfNeeded()
    }
    
    func configureCell(with model: MovieViewModel){
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
        
        titleLabel.text = model.title
        entertainmetType.text = model.mediaType == "movie" ? "F I L M" : "S E R I E S"
        overViewLabel.text = model.overview
        categoryLabel.text = model.category
    }
    
}

