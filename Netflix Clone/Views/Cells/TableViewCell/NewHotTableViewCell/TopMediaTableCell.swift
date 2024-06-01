//
//  TopMediaTableCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 06/04/2024.
//

import UIKit

class TopMediaTableCell: NewHotTableViewCell {
    
    //MARK: - Declare Variables
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let rankLabel = NFBodyLabel(fontSize: 26, fontWeight: .bold, textAlignment: .center)
    
    static let identifier = "TopMediaTableCell"
    
    //MARK: - Load View
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        topStackView.addArrangedSubview(rankLabel)
        topStackView.addArrangedSubview(backdropImageView)
        [
            topStackView ,
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
    func configureMediaRank(at rank: Int) {rankLabel.text = "\(rank+1)"}
    
    
    
    //MARK: - Constraints
    func setupHorizantolStackConstraints() {
        topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3).isActive = true
        topStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
        
        // rand width
        rankLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func applyConstraints() {
        setupNetflixLogoConstraints(bottomTo: logoView)
        setupButtonsConstraints(for: shareButton, myListButton, playButton)
        setupHorizantolStackConstraints()
        setupTypeLabelConstraints()
        setupLogoViewConstraints()
        setupTitleOverviewLabelConstraints()
        setupCategoryLabelConstraints()
    }
}
