//
//  SeasonsListVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 28/03/2024.
//

import UIKit

class SeasonsListVC: UIViewController {
    
    protocol Delegate: AnyObject {func selectSeason(number seasonNumber: Int)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureViews()
        applyConstraints()
    }
    
    init(seasonsCount: Int, currentSeason: Int) {
        super.init(nibName: nil, bundle: nil)
        setupSeasonsButtons(with: seasonsCount)
        setupStackBeforAnimation()
        setActiveSeasonButton(is: currentSeason)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateButtonsAppearing()
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    //MARK: - Configure Views
    func configureViews() {
        [bluryBackground, scrollView, exitButtonBackground].forEach{view.addSubview($0)}
        scrollView.addSubview(stackContainer)
        exitButtonBackground.addSubview(exitButton)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        bluryBackground.addGrayBlurEffect()
    }
    
    private func setupSeasonsButtons(with totalSeasons: Int) {
        decalreUIButtons(with: totalSeasons)
        addButtonsTarget()
    }
    
    
    private func decalreUIButtons(with totalSeasons: Int) {
        var seasonsCount = 0
        for season in 1...totalSeasons {
            seasonsCount += 1
            let seasonView = NFPlainButton(title: "Season \(season)", fontSize: 18, fontWeight: .regular, fontColorOnly: .lightGray)
            seasonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            seasonsButtons.append(seasonView)
            stackContainer.addArrangedSubview(seasonView)
        }
        // insert padding
        stackContainer.insertArrangedSubview(upperPaddingView, at: 0)
        stackContainer.insertArrangedSubview(lowerPaddingView, at: stackContainer.arrangedSubviews.count)
    }
    
    private func addButtonsTarget() {
        for button in seasonsButtons {button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)}
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        for button in seasonsButtons {
            if button == sender {
                guard let buttonIndex = seasonsButtons.firstIndex(of: button) else { return }
                let seasonNumber = buttonIndex+1
                setActiveSeasonButton(is: seasonNumber)
                delegate.selectSeason(number: seasonNumber)
            }
        }
        dismiss(animated: true)
    }
    
    
    @objc func exitButtonTapped() {dismiss(animated: true)}
    
    //MARK: - Animate Stack's SubViews
    private func setActiveSeasonButton(is number: Int) {
        let activeButton = seasonsButtons[number-1]
        activeButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 27)
            outgoing.foregroundColor = .white
            return outgoing
        }
    }
    
    private func setupStackBeforAnimation() {
        let totalButtons = self.seasonsButtons.count
        let halfViewheight = view.bounds.height/3
        
        for buttonIndex in seasonsButtons.indices {
            let portionOfHeight = Double(buttonIndex + 1) / Double(totalButtons)
            let heightAdded = portionOfHeight * halfViewheight
            
            seasonsButtons[buttonIndex].alpha = 0
            seasonsButtons[buttonIndex].transform = CGAffineTransform(translationX: 0, y: heightAdded)
        }
    }
    
    private func animateButtonsAppearing() {
        let totalButtons = self.seasonsButtons.count
        let duration: TimeInterval = 0.4
        
        for buttonIndex in self.seasonsButtons.indices {
            let portionOfTotalDuration = Double(buttonIndex + 1) / Double(totalButtons)
            let lessButtonsDuration = portionOfTotalDuration * duration
            
            UIView.animate(withDuration: totalButtons > 7 ? duration : lessButtonsDuration) {
                self.seasonsButtons[buttonIndex].alpha = 1
                self.seasonsButtons[buttonIndex].transform = .identity
            }
            
        }
    }
    
    
    //MARK: - Constraints
    private func applyConstraints() {
        // background frame
        bluryBackground.frame = view.bounds
        
        // scrollView
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: exitButtonBackground.topAnchor, constant: -20).isActive = true
        
        // stackView
        stackContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackContainer.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor).isActive = true
        stackContainer.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor).isActive = true
        stackContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        
        
        // exitButton constraints
        exitButtonBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitButtonBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        exitButtonBackground.widthAnchor.constraint(equalToConstant: 50).isActive = true
        exitButtonBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        exitButton.centerXAnchor.constraint(equalTo: exitButtonBackground.centerXAnchor).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: exitButtonBackground.centerYAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalTo: exitButtonBackground.widthAnchor).isActive = true
        exitButton.heightAnchor.constraint(equalTo: exitButtonBackground.heightAnchor).isActive = true
        
        
    }
    
    //MARK: - Declare Views & Variables
    let exitButtonBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let upperPaddingView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.15).isActive = true
        return view
    }()
    
    let lowerPaddingView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.1).isActive = true
        return view
    }()
    
    let stackContainer : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bluryBackground = UIView()
    let exitButton = NFSymbolButton(imageName: "xmark", imageSize: 17, imageColor: .black)
    
    var seasonsButtons = [NFPlainButton]()
    weak var delegate: Delegate!
}

