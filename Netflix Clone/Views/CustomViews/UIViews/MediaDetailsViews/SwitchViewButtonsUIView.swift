//
//  SwitchViewButtonsUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 23/01/2024.
//

import UIKit

class SwitchViewButtonsUIView: UIView {
    
    protocol Delegate: AnyObject { func buttonOneAction(); func buttonTwoAction() }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        [buttonOne,buttonTwo,redLineOne,redLineTwo].forEach{addSubview($0)}
        buttonsTarget()
        applyConstraints()
    }
    
    convenience init(buttonOneTitle: String, buttonTwoTitle: String) {
        self.init()
        buttonOne.configuration?.title = buttonOneTitle
        buttonTwo.configuration?.title = buttonTwoTitle
    }
    
    //MARK: - Button target methods
    func buttonsTarget() {
        buttonOne.addTarget(self, action: #selector(buttonOnePressed), for: .touchUpInside)
        buttonTwo.addTarget(self, action: #selector(buttonTwoPressed), for: .touchUpInside)
    }
    
    func triggerButtonOne() {buttonOne.sendActions(for: .touchUpInside)}
    
    //MARK: - Button Pressed Actions
    @objc private func buttonOnePressed() {
        handleUIForButtonOne()
        delegate?.buttonOneAction()
    }
    
    @objc private func buttonTwoPressed() {
        handleUIForButtonTwo()
        delegate?.buttonTwoAction()
    }
    
    // Button UI change method
    func handleUIForButtonOne() {
        // Change redLine placment to be over moreButton
        self.layoutIfNeeded()
        let redLineOneWidth = buttonOne.bounds.width - 25
        let redLineOneOriginPoint = buttonOne.frame.minX + 10
        let redLineTwoOriginPoint = buttonTwo.frame.minX + 10
        
        if buttonOne.configuration?.baseForegroundColor == .lightGray{
            redLineOne.frame = CGRect(x: redLineOneOriginPoint, y: 0, width: 0, height: 4)
            UIView.animate(withDuration: 0.2) {
                self.redLineTwo.frame = CGRect(x: redLineTwoOriginPoint, y: 0, width: 0, height: 4)
                self.redLineOne.frame = CGRect(x: redLineOneOriginPoint, y: 0, width: redLineOneWidth, height: 4)
            }
            redLineOne.center = CGPoint(x: buttonOne.frame.midX, y: 1)
        }
        
        // Change tapped moreButton color
        buttonOne.configuration?.baseForegroundColor = .white
        buttonTwo.configuration?.baseForegroundColor = .lightGray
    }
    
    func handleUIForButtonTwo() {
        // Change redLine placment to be over moreButton
        self.layoutIfNeeded()
        let redLineTwoWidth = buttonTwo.bounds.width - 25
        let redLineOneOriginPoint = buttonOne.frame.minX + 10
        let redLineTwoOriginPoint = buttonTwo.frame.minX + 10
        
        if buttonTwo.configuration?.baseForegroundColor == .lightGray{
            redLineTwo.frame = CGRect(x: redLineTwoOriginPoint, y: 0, width: 0, height: 4)
            UIView.animate(withDuration: 0.2) {
                self.redLineOne.frame = CGRect(x: redLineOneOriginPoint, y: 0, width: 0, height: 4)
                self.redLineTwo.frame = CGRect(x: redLineTwoOriginPoint, y: 0, width: redLineTwoWidth, height: 4)
            }
            redLineTwo.center = CGPoint(x: buttonTwo.frame.midX, y: 1)
        }
        
        // Change tapped moreButton color
        buttonTwo.configuration?.baseForegroundColor = .white
        buttonOne.configuration?.baseForegroundColor = .lightGray
    }
    
    //MARK: - Constraints
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // Button 1
            buttonOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -4),
            buttonOne.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            buttonOne.heightAnchor.constraint(equalTo: buttonOne.heightAnchor),
            
            // Button 2
            buttonTwo.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: -10),
            buttonTwo.topAnchor.constraint(equalTo: buttonOne.topAnchor),
            buttonTwo.heightAnchor.constraint(equalTo: buttonOne.heightAnchor)
        ])
    }
    
    //MARK: - Views Declaration
    private let redLineOne: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.red
        return rectangle
    }()
    
    private let redLineTwo: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.red
        return rectangle
    }()
    
    private let buttonOne = NFPlainButton(title: "", buttonColor: .lightGray, fontSize: 16, fontWeight: .bold)
    private let buttonTwo = NFPlainButton(title: "", buttonColor: .lightGray, fontSize: 16, fontWeight: .bold)
    
    weak var delegate: Delegate?
    
    
    required init?(coder: NSCoder) {fatalError()}
}
