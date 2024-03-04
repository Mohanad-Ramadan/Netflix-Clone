//
//  NewHotCategoryBarUIView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 17/01/2024.
//

import UIKit

class NewHotCategoryBarUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(scrollView)
        configureButtons()
        buttonsTarget()
    }
    
    //MARK: - Make comingSoonButton tapped at first view load
    @objc func comingSoonButtonTapped() {
        comingSoonButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        comingSoonButton.sendActions(for: .touchUpInside)
    }
    
    //MARK: - Button pressed Actions
    @objc private func buttonPressed(_ sender: UIButton) {
        self.handleUI(sender)
        self.handleButtonIndex(buttonPressed: sender)
        
        // Post key to Notifiy the NewAndHotVC to fetch agian
        NotificationCenter.default.post(name: NSNotification.Name(Constants.categoryNewHotVCKey), object: nil)
    }
    
    // Get selected button index
    func handleButtonIndex(buttonPressed: UIButton) {
        if let index = buttons.firstIndex(of: buttonPressed) {
            selectedButtonIndex = index
        }
    }
    
    // Selected button UI change
    func handleUI(_ sender: UIButton) {
        // Change colors
        for button in buttons {
            button.configuration?.baseBackgroundColor = (button == sender) ? .white : .black
            button.configuration?.baseForegroundColor = (button == sender) ? .black : .white
        }
        
        // Focus scrollView to button's offest if not fully shown
        let buttonFirstPoint = sender.frame.minX
        let buttonLastPoint = sender.frame.maxX
        let buttonMidPoint = sender.frame.midX
        
        let firstVisiblePoint = scrollView.bounds.minX
        let lastVisiblePoint = scrollView.bounds.maxX
        
        let fullScrollView = scrollView.frame.maxX - 30
        let halfScrollView = scrollView.frame.midX
        
        
        if buttonFirstPoint <= firstVisiblePoint || buttonLastPoint >= lastVisiblePoint {
            switch buttons.firstIndex(of: sender) {
                
                //the First button case
            case 0:
                let targetOffset = CGPoint(x: buttonFirstPoint, y: 0)
                scrollView.setContentOffset(targetOffset, animated: true)
                
                //the Last button case
            case 3:
                let targetOffset = CGPoint(x: buttonLastPoint - fullScrollView, y: 0)
                scrollView.setContentOffset(targetOffset, animated: true)
                
                //middle buttons case
            default:
                let targetOffset = CGPoint(x: buttonMidPoint - halfScrollView, y: 0)
                scrollView.setContentOffset(targetOffset, animated: true)
            }
        }
    }
    
    //MARK: - Button target methods
    func buttonsTarget() {
        comingSoonButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        everyoneWatchingButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        toptenTvShowsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        toptenMoviesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    //MARK: - Configure Buttons
    private func configureButtons() {
        
        [comingSoonButton, everyoneWatchingButton, toptenTvShowsButton, toptenMoviesButton].forEach {scrollView.addSubview($0)}
        
        comingSoonButton.configureButtonImageWith(UIImage(resource: .popcorn), width: 20, height: 20, placement: .leading, padding: 8)
        everyoneWatchingButton.configureButtonImageWith(UIImage(resource: .fire), width: 20, height: 20, placement: .leading, padding: 8)
        toptenTvShowsButton.configureButtonImageWith(UIImage(resource: .top10), width: 20, height: 20, placement: .leading, padding: 8)
        toptenMoviesButton.configureButtonImageWith(UIImage(resource: .top10), width: 20, height: 20, placement: .leading, padding: 8)
        
        // Constraints
        NSLayoutConstraint.activate([
            // ScrollView Containter
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            scrollView.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),

            // Button 1
            comingSoonButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            comingSoonButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            comingSoonButton.heightAnchor.constraint(equalToConstant: 35),

            // Button 2
            everyoneWatchingButton.leadingAnchor.constraint(equalTo: comingSoonButton.trailingAnchor, constant: 10),
            everyoneWatchingButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            everyoneWatchingButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),

            // Button 3
            toptenTvShowsButton.leadingAnchor.constraint(equalTo: everyoneWatchingButton.trailingAnchor, constant: 10),
            toptenTvShowsButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            toptenTvShowsButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),

            // Button 4
            toptenMoviesButton.leadingAnchor.constraint(equalTo: toptenTvShowsButton.trailingAnchor, constant: 10),
            toptenMoviesButton.topAnchor.constraint(equalTo: comingSoonButton.topAnchor),
            toptenMoviesButton.heightAnchor.constraint(equalTo: comingSoonButton.heightAnchor),
            toptenMoviesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
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
    
    
    private let comingSoonButton = NFFilledButton(title: "Coming Soon", titleColor: .white, backgroundColor: .black, fontSize: 14, fontWeight: .bold, cornerStyle: .capsule)
    private let everyoneWatchingButton = NFFilledButton(title: "Everyone's Watching", titleColor: .white, backgroundColor: .black, fontSize: 14, fontWeight: .bold, cornerStyle: .capsule)
    private let toptenTvShowsButton = NFFilledButton(title: "Top 10 TV Shows", titleColor: .white, backgroundColor: .black, fontSize: 14, fontWeight: .bold, cornerStyle: .capsule)
    private let toptenMoviesButton = NFFilledButton(title: "Top 10 Movies", titleColor: .white, backgroundColor: .black, fontSize: 14, fontWeight: .bold, cornerStyle: .capsule)
    
    
    private lazy var buttons: [UIButton] = [comingSoonButton, everyoneWatchingButton, toptenTvShowsButton, toptenMoviesButton]
    
    var selectedButtonIndex = 0
    
    
    required init?(coder: NSCoder) {fatalError()}
}
