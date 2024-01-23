//
//  TableViewSwitchButtonsUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 23/01/2024.
//

import UIKit

class TableViewSwitchButtonsUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(moreButton)
        addSubview(trailerButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            moreButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            moreButton.topAnchor.constraint(equalTo: redSelectLine.bottomAnchor, constant: 15),
            moreButton.heightAnchor.constraint(equalTo: moreButton.heightAnchor),
            
            // Button 2
            trailerButton.leadingAnchor.constraint(equalTo: moreButton.trailingAnchor, constant: 25),
            trailerButton.topAnchor.constraint(equalTo: moreButton.topAnchor),
            trailerButton.heightAnchor.constraint(equalTo: moreButton.heightAnchor),
            
            // Red select line
            redSelectLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            redSelectLine.topAnchor.constraint(equalTo: topAnchor),
            redSelectLine.heightAnchor.constraint(equalToConstant: 3),
            redSelectLine.widthAnchor.constraint(equalTo: moreButton.widthAnchor),
        ])
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 21, weight: .semibold)
            return outgoing
        }
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private lazy var moreButton: UIButton = createButton(title: "More Like This")
    private lazy var trailerButton: UIButton = createButton(title: "Trailer & More")
    
    private let redSelectLine: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.red
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        return rectangle
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
