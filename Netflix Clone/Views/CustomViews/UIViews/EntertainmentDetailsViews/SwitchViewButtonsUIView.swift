//
//  ViewSwitchButtonsUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 23/01/2024.
//

import UIKit


enum SelectedView {
    case moreIdeasView, trailerView
}


class SwitchViewButtonsUIView: UIView {
    
    protocol Delegate: AnyObject { func buttonOneAction(); func buttonTwoAction() }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(buttonOne)
        addSubview(buttonTwo)
        addSubview(redSelectLine)
        buttonsTarget()
        applyConstraints()
    }
    
    init(buttonOneTitle: String, buttonTwoTitle: String) {
        super.init(frame: .zero)
        buttonOne.configuration?.title = buttonOneTitle
        buttonTwo.configuration?.title = buttonTwoTitle
        
    }
    
    //MARK: - moreButton tapped at first load
    @objc func firstApperanceAction() {buttonOne.sendActions(for: .touchUpInside)}
    
    //MARK: - Button Pressed Actions
    @objc private func buttonPressed(_ sender: UIButton) {
        handleUIFor(sender)
        changeViewFor(sender)

        // Post key to Notifiy the Entertainment to layout subviews agian
        NotificationCenter.default.post(name: NSNotification.Name(Constants.entertainmentVCKey), object: nil)
    }
    
    // Button backend method
    func changeViewFor( _ sender: UIButton) {
        selectedButtonView = sender == buttonOne ? SelectedView.moreIdeasView : SelectedView.trailerView
    }
    
    
    // Button UI change method
    func  handleUIFor(_ sender: UIButton) {
        let redLineMidPoint = redSelectLine.frame.midX
        let moreButtonMidPoint = buttonOne.frame.midX
        let trailerButtonMidPoint = buttonTwo.frame.midX
        
        if sender == buttonOne{
            // Change redLine placment to be over moreButton
            redSelectLine.center = redLineMidPoint != moreButtonMidPoint ? CGPoint(x: moreButtonMidPoint, y: 0) : CGPoint(x: trailerButtonMidPoint, y: 0)
            
            // Change tapped moreButton color
            buttonOne.configuration?.baseForegroundColor = .white
            buttonTwo.configuration?.baseForegroundColor = .lightGray
        } else {
            // Change redLine placment to be over moreButton
            redSelectLine.center = redLineMidPoint != trailerButtonMidPoint ? CGPoint(x: trailerButtonMidPoint, y: 0) : CGPoint(x: moreButtonMidPoint, y: 0)
            
            // Change tapped trailerButton color
            buttonTwo.configuration?.baseForegroundColor = .white
            buttonOne.configuration?.baseForegroundColor = .lightGray
        }
    }
    
    //MARK: - Button target methods
    func buttonsTarget() {
        buttonOne.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        buttonTwo.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    //MARK: - Constraints
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            buttonOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -4),
            buttonOne.topAnchor.constraint(equalTo: redSelectLine.bottomAnchor, constant: 4),
            buttonOne.heightAnchor.constraint(equalTo: buttonOne.heightAnchor),
            
            // Button 2
            buttonTwo.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: -10),
            buttonTwo.topAnchor.constraint(equalTo: buttonOne.topAnchor),
            buttonTwo.heightAnchor.constraint(equalTo: buttonOne.heightAnchor),
            
            // Red select line
            redSelectLine.centerXAnchor.constraint(equalTo: buttonOne.centerXAnchor),
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
    
    private let buttonOne = NFPlainButton(title: "Button", titleColor: .lightGray, fontSize: 16, fontWeight: .bold)
    private let buttonTwo = NFPlainButton(title: "Button", titleColor: .lightGray, fontSize: 16, fontWeight: .bold)
    
    
    var selectedButtonView : SelectedView?
    
    weak var delegate: Delegate?
    
    required init?(coder: NSCoder) {fatalError()}

}
