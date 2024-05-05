//
//  TopMediaTableCell.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 06/04/2024.
//

import UIKit

class TopMediaTableCell: NewHotTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [rankLabel, backdropImageView].forEach {topStackView.addArrangedSubview($0)}
        [topStackView ,logoView ,netflixLogo ,entertainmetType ,titleLabel ,overViewLabel ,genresLabel ].forEach { contentView.addSubview($0) }
        
        applyConstraints()
    }
    
    func configureMediaRank(at rank: Int) {rankLabel.text = "\(rank+1)"}
    
    func setupHorizantolStackConstraints() {
        rankLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3).isActive = true
        topStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
    }
    
    private func applyConstraints() {
        setupHorizantolStackConstraints()
        setupNetflixLogoConstraints(bottomTo: logoView)
        setupTypeLabelConstraints()
        setupButtonsConstraints()
        setupLogoViewConstraints()
        setupTitleOverviewLabelConstraints()
        setupCategoryLabelConstraints()
    }
    
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
    
    required init?(coder: NSCoder) {fatalError()}
}
