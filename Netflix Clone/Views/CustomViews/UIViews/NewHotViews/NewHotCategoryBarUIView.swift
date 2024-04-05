//
//  NewHotCategoryBarUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 17/01/2024.
//

import UIKit

class NewHotCategoryBarUIView: UIView{
    
    protocol Delegate: AnyObject {func buttonPressed(buttonIndex: Int)}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        configureButtons()
        applyConstraints()
        buttonsTarget()
    }
    
    //MARK: - Configure Buttons
    private func configureButtons() {
        addSubview(scrollView)
        scrollView.addSubview(buttonsStackView)
        buttons.forEach{buttonsStackView.addArrangedSubview($0)}
        
        comingSoonButton.configureButtonImageWith(UIImage(resource: .popcorn), width: 20, height: 20, placement: .leading, padding: 8)
        everyoneWatchingButton.configureButtonImageWith(UIImage(resource: .fire), width: 20, height: 20, placement: .leading, padding: 8)
        toptenTvShowsButton.configureButtonImageWith(UIImage(resource: .top10), width: 20, height: 20, placement: .leading, padding: 8)
        toptenMoviesButton.configureButtonImageWith(UIImage(resource: .top10), width: 20, height: 20, placement: .leading, padding: 8)
    }
    
    //MARK: - Make comingSoonButton tapped at first view load
    @objc func comingSoonButtonTapped() {
        comingSoonButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        comingSoonButton.sendActions(for: .touchUpInside)
    }
    
    //MARK: - Button pressed Actions
    @objc private func buttonPressed(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        self.animateButton(atIndex: index)
        delegate.buttonPressed(buttonIndex: index)
    }
    
    // Selected button UI change
    func animateButton(atIndex buttonIndex: Int) {
        let tappedButton = buttons[buttonIndex]
        // Change tapped button color and reset the others
        for button in buttons {
            button.configuration?.baseBackgroundColor = (button == tappedButton) ? .white : .black
            button.configuration?.baseForegroundColor = (button == tappedButton) ? .black : .white
        }
        // change scrollView offset when a button is tapped
        let buttonFirstPoint = tappedButton.frame.minX
        let buttonLastPoint = tappedButton.frame.maxX
        let buttonMidPoint = tappedButton.frame.midX
        let scrollViewFrame = scrollView.frame.maxX
        
        if buttons[0] == tappedButton {
            let targetOffset = CGPoint(x: buttonFirstPoint, y: 0)
            scrollView.setContentOffset(targetOffset, animated: true)
        } else if buttons[buttons.count-1] == tappedButton {
            let targetOffset = CGPoint(x: buttonLastPoint - scrollViewFrame, y: 0)
            scrollView.setContentOffset(targetOffset, animated: true)
        } else {
            let targetOffset = CGPoint(x: buttonMidPoint - scrollViewFrame/2, y: 0)
            scrollView.setContentOffset(targetOffset, animated: true)
        }
    }
    
    //MARK: - Button target methods
    func buttonsTarget() {
        comingSoonButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        everyoneWatchingButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        toptenTvShowsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        toptenMoviesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    
    //MARK: - Constraints
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            // scrollView constriants
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        buttonsStackView.heightAnchor.constraint(lessThanOrEqualTo: scrollView.heightAnchor).isActive = true
        let scrollContentGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            // stackView
            buttonsStackView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Declare Views
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let comingSoonButton = NFFilledButton(title: "Coming Soon", titleColor: .white, backgroundColor: .black, fontSize: 14, fontWeight: .bold, cornerStyle: .capsule)
    private let everyoneWatchingButton = NFFilledButton(title: "Everyone's Watching", titleColor: .white, backgroundColor: .black, fontSize: 14, fontWeight: .bold, cornerStyle: .capsule)
    private let toptenTvShowsButton = NFFilledButton(title: "Top 10 TV Shows", titleColor: .white, backgroundColor: .black, fontSize: 14, fontWeight: .bold, cornerStyle: .capsule)
    private let toptenMoviesButton = NFFilledButton(title: "Top 10 Movies", titleColor: .white, backgroundColor: .black, fontSize: 14, fontWeight: .bold, cornerStyle: .capsule)
    
    
    private lazy var buttons: [UIButton] = [comingSoonButton, everyoneWatchingButton, toptenTvShowsButton, toptenMoviesButton]

    weak var delegate: Delegate!
    
    required init?(coder: NSCoder) {fatalError()}
}


