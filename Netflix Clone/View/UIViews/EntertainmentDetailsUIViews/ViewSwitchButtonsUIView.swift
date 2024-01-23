//
//  ViewSwitchButtonsUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 23/01/2024.
//

import UIKit

class ViewSwitchButtonsUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(moreButton)
        addSubview(trailerButton)
        addSubview(redSelectLine)
        buttonsTarget()
        applyConstraints()
    }
    
    
    //MARK: - Button Pressed Actions
    @objc func buttonPressed(_ sender: UIButton) {
        IndicateOfSelecting(sender)
    }
    
    // Selected button UI change
    func IndicateOfSelecting(_ sender: UIButton) {
        // Defualt red line offest that is over moreButton
        let redLineMidPoint = redSelectLine.frame.midX
        let moreButtonMidPoint = moreButton.frame.midX
        let trailerButtonMidPoint = trailerButton.frame.midX
        
        if sender == moreButton, redLineMidPoint != moreButtonMidPoint {
            redSelectLine.center = CGPoint(x: moreButtonMidPoint, y: 0)
        } else if sender == trailerButton, redLineMidPoint != trailerButtonMidPoint {
            redSelectLine.center = CGPoint(x: trailerButtonMidPoint, y: 0)
        }
    }
    
    //MARK: - Button target methods
    func buttonsTarget() {
        moreButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        trailerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    //MARK: - Constraints
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            moreButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            moreButton.topAnchor.constraint(equalTo: redSelectLine.bottomAnchor, constant: 10),
            moreButton.heightAnchor.constraint(equalTo: moreButton.heightAnchor),
            
            // Button 2
            trailerButton.leadingAnchor.constraint(equalTo: moreButton.trailingAnchor, constant: 5),
            trailerButton.topAnchor.constraint(equalTo: moreButton.topAnchor),
            trailerButton.heightAnchor.constraint(equalTo: moreButton.heightAnchor),
            
            // Red select line
            redSelectLine.centerXAnchor.constraint(equalTo: moreButton.centerXAnchor),
            redSelectLine.topAnchor.constraint(equalTo: topAnchor),
            redSelectLine.heightAnchor.constraint(equalToConstant: 5),
            redSelectLine.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    //MARK: - Views Declaration
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 17, weight: .bold)
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

#Preview{
    ViewSwitchButtonsUIView()
}
