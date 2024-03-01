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
    
    //MARK: - moreButton tapped at first load
    @objc func moreButtonTapped() {
        moreButton.sendActions(for: .touchUpInside)
    }
    
    //MARK: - Button Pressed Actions
    @objc private func buttonPressed(_ sender: UIButton) {
        handleUIFor(sender)
        changeViewFor(sender)

        // Post key to Notifiy the Entertainment to layout subviews agian
        NotificationCenter.default.post(name: NSNotification.Name(Constants.entertainmentVCKey), object: nil)
    }
    
    // Button backend method
    func changeViewFor(_ sender: UIButton) {
        selectedButtonView = sender == moreButton ? SelectedView.moreIdeasView : SelectedView.trailerView
    }
    
    
    // Button UI change method
    func  handleUIFor(_ sender: UIButton) {
        let redLineMidPoint = redSelectLine.frame.midX
        let moreButtonMidPoint = moreButton.frame.midX
        let trailerButtonMidPoint = trailerButton.frame.midX
        
        if sender == moreButton{
            // Change redLine placment to be over moreButton
            redSelectLine.center = redLineMidPoint != moreButtonMidPoint ? CGPoint(x: moreButtonMidPoint, y: 0) : CGPoint(x: trailerButtonMidPoint, y: 0)
            
            // Change tapped moreButton color
            moreButton.configuration?.baseForegroundColor = .white
            trailerButton.configuration?.baseForegroundColor = .lightGray
        } else {
            // Change redLine placment to be over moreButton
            redSelectLine.center = redLineMidPoint != trailerButtonMidPoint ? CGPoint(x: trailerButtonMidPoint, y: 0) : CGPoint(x: moreButtonMidPoint, y: 0)
            
            // Change tapped trailerButton color
            trailerButton.configuration?.baseForegroundColor = .white
            moreButton.configuration?.baseForegroundColor = .lightGray
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
            moreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -4),
            moreButton.topAnchor.constraint(equalTo: redSelectLine.bottomAnchor, constant: 4),
            moreButton.heightAnchor.constraint(equalTo: moreButton.heightAnchor),
            
            // Button 2
            trailerButton.leadingAnchor.constraint(equalTo: moreButton.trailingAnchor, constant: -10),
            trailerButton.topAnchor.constraint(equalTo: moreButton.topAnchor),
            trailerButton.heightAnchor.constraint(equalTo: moreButton.heightAnchor),
            
            // Red select line
            redSelectLine.centerXAnchor.constraint(equalTo: moreButton.centerXAnchor),
            redSelectLine.topAnchor.constraint(equalTo: topAnchor),
            redSelectLine.heightAnchor.constraint(equalToConstant: 4),
            redSelectLine.widthAnchor.constraint(equalToConstant: 112),
        ])
    }
    
    //MARK: - Views Declaration
    private let redSelectLine: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.red
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        return rectangle
    }()
    
    private let moreButton = NFPlainButton(title: "More Like This", titleColor: .lightGray, fontSize: 16, fontWeight: .bold)
    private let trailerButton = NFPlainButton(title: "Trailer & More", titleColor: .lightGray, fontSize: 16, fontWeight: .bold)
    
    
    var selectedButtonView : SelectedView?
    
    required init?(coder: NSCoder) {fatalError()}

}

//MARK: - Change Views Enum
enum SelectedView {
    case moreIdeasView, trailerView
}
