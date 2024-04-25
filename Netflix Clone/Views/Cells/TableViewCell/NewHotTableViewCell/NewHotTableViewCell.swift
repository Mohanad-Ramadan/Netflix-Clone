//
//  New&HotTableViewCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 07/12/2023.
//

import UIKit

class NewHotTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
    }
    
    func configure(with media: Media) {
        Task {
            do {
                let id = media.id
                let mediaType = media.mediaType
                
                // images
                let images = try await NetworkManager.shared.getImagesFor(mediaId: id, ofType: mediaType ?? "movie")
                let logoAspectRatio = UIHelper.UIKit.getLogoDetailsFrom(images)?.1
                let logoPath = UIHelper.UIKit.getLogoDetailsFrom(images)?.0
                let backdropPath = UIHelper.UIKit.getBackdropPathFrom(images)
                configureCellImages(with: MovieViewModel(logoAspectRatio: logoAspectRatio, logoPath: logoPath, backdropsPath: backdropPath))
                
                // details
                if mediaType == nil || mediaType == "movie" {
                    let detail: MovieDetail = try await NetworkManager.shared.getDetailsFor(mediaId: id, ofType: "movie")
                    let detailCategory = detail.separateGenres(with: " • ")
                    configureCellDetails(with: MovieViewModel(title: detail.title, overview: detail.overview, category: detailCategory, mediaType: media.mediaType ,releaseDate: detail.releaseDate))
                } else {
                    let detail: TVDetail = try await NetworkManager.shared.getDetailsFor(mediaId: id, ofType: "tv")
                    let detailCategory = detail.separateGenres(with: " • ")
                    configureCellDetails(with: MovieViewModel(title: detail.name, overview: detail.overview, category: detailCategory, mediaType: media.mediaType))
                }
            } catch { print("Error getting images:", error.localizedDescription) }
            
        }
         
    }
    
    
    //MARK: - Configure Cell
    func configureCellImages(with media: MovieViewModel){
        backdropImageView.downloadImageFrom(media.backdropsPath ?? "noPath")
        logoView.downloadImageFrom(media.logoPath ?? "noPath")
        if let logoAspectRatio = media.logoAspectRatio {
            updateLogoWidthBy(logoAspectRatio > 4 ? 4 : logoAspectRatio)
        }
    }
    
    func configureCellDetails(with media: MovieViewModel){
        titleLabel.text = media.title
        entertainmetType.text = media.mediaType == "tv" ? "S E R I E S" : "F I L M"
        overViewLabel.text = media.overview
        genresLabel.text = media.category
        
    }
    
    
    //MARK: - Subviews Constraints
    
    
    // Backdrop image view constraints
    func setupBackdropImageViewConstraints(dayLabel: UIView? = nil) {
        if (dayLabel != nil) {
            backdropImageView.leadingAnchor.constraint(equalTo: dayLabel!.trailingAnchor, constant: 10).isActive = true
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
            backdropImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
        } else {
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3).isActive = true
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
            backdropImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
        }
    }
    
    // Buttons constraints
     func setupButtonsConstraints() {
        infoButton.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 10).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        remindMeButton.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 10).isActive = true
        remindMeButton.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor).isActive = true
        remindMeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //Logo view
     func setupLogoViewConstraints() {
        logoView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor,constant: 10).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        logoView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
    }
    
    func setupNetflixLogoConstraints(bottomTo view: UIView) {
        netflixLogo.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
        netflixLogo.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        netflixLogo.heightAnchor.constraint(equalToConstant: 15).isActive = true
        netflixLogo.widthAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    //Type and Logo constraints
     func setupTypeLabelConstraints() {
        entertainmetType.leadingAnchor.constraint(equalTo: netflixLogo.trailingAnchor, constant: 4).isActive = true
        entertainmetType.centerYAnchor.constraint(equalTo: netflixLogo.centerYAnchor).isActive = true
        entertainmetType.bottomAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        entertainmetType.widthAnchor.constraint(equalTo: entertainmetType.widthAnchor).isActive = true
    }
    
    // Title and overview label constraints
     func setupTitleOverviewLabelConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: netflixLogo.bottomAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: -20).isActive = true
        
        overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        overViewLabel.bottomAnchor.constraint(equalTo: genresLabel.topAnchor, constant: -10).isActive = true
        overViewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        overViewLabel.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: -5).isActive = true
    }
    
    // Category label constraints
     func setupCategoryLabelConstraints() {
        genresLabel.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 10).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: overViewLabel.leadingAnchor).isActive = true
        genresLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        genresLabel.widthAnchor.constraint(equalTo: genresLabel.widthAnchor).isActive = true
    }
    
    
    //MARK: - Update Constraints
     func updateLogoWidthBy(_ aspectRatio: CGFloat) {
        logoView.removeConstraint(logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor))
        let widthConstraint = logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: aspectRatio)
        widthConstraint.priority = .defaultHigh
        widthConstraint.isActive = true
        
        layoutIfNeeded()
    }
    
    //MARK: - Declare Subviews
     let backdropImageView = NFWebImageView(cornerRadius: 10, autoLayout: false)
    
     let remindMeButton = NFPlainButton(title: "Remind Me", image: UIImage(systemName: "bell"), imagePlacement: .top, fontSize: 12, fontWeight: .regular, fontColorOnly: .gray)
    
     let infoButton = NFPlainButton(title: "Info", image: UIImage(systemName: "info.circle"), imagePlacement: .top, fontSize: 12, fontWeight: .regular, fontColorOnly: .gray)
    
     let logoView = NFWebImageView(contentMode: .scaleAspectFit, autoLayout: false)
    
     let netflixLogo = NFImageView(image: .netflixClone)
    
     let entertainmetType = NFBodyLabel(color: .lightGray, fontSize: 8, fontWeight: .semibold)
        
     let titleLabel = NFBodyLabel(fontSize: 22, fontWeight: .bold, lines: 0)
    
     let overViewLabel = NFBodyLabel(color: .lightGray, fontSize: 15, lines: 3)
        
     let genresLabel = NFBodyLabel(fontSize: 13)
    
    required init?(coder: NSCoder) {fatalError()}
}

