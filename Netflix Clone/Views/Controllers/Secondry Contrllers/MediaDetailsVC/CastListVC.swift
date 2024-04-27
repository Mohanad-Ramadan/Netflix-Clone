//
//  CastListVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/04/2024.
//

import UIKit

class CastListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureViews()
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - Configure Views
    func configureViews() {
        [bluryBackground,scrollView,exitButtonBackground].forEach{view.addSubview($0)}
        scrollView.addSubview(stackContainer)
        exitButtonBackground.addSubview(exitButton)
        
        bluryBackground.frame = view.bounds
        bluryBackground.addGrayBlurEffect()
        
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    @objc func exitButtonTapped() { dismiss(animated: true) }
    
    //MARK: - Constriants
    func applyConstraints() {
        // scrollView
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: exitButtonBackground.topAnchor, constant: -20).isActive = true
        
        stackContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        // stackView
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
    
    //MARK: - Adding Labels SubViews
    private func addCastViews(with cast: CastViewModel) {
        var viewNumber: Int = 0
        let actors = cast.createActorsArray()
        let crew = cast.createCrewArray()
        
        // add actorsLabel to the stack
        stackContainer.addArrangedSubview(castTitle)
        setupLabels(for: actors, viewsCount: &viewNumber)
        
        // add crewLabels to the stack
        stackContainer.addArrangedSubview(crewTitle)
        setupLabels(for: crew, viewsCount: &viewNumber)
        
    }
    
    
    private func setupLabels(for castArray: [String], viewsCount: inout Int) {
        for memberLabel in castArray {
            viewsCount += 1
            let LabelView = NFBodyLabel(text: "", color: .lightGray, fontSize: 18, fontWeight: .semibold, textAlignment: .center, lines: 1, autoLayout: true)
            LabelView.text = memberLabel
            stackContainer.addArrangedSubview(LabelView)
            if viewsCount == castArray.count {
                stackContainer.setCustomSpacing(30, after: LabelView)
                viewsCount = 0
            }
        }
    }
    
    //MARK: - Declare Views & Variables
    let stackContainer : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fillProportionally
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let exitButtonBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let castTitle = NFBodyLabel(text: "Cast:", fontSize: 21, fontWeight: .semibold, textAlignment: .center, lines: 1, autoLayout: true)
    let crewTitle = NFBodyLabel(text: "Crew:", fontSize: 21, fontWeight: .semibold, textAlignment: .center, lines: 1, autoLayout: true)
    
    let exitButton = NFSymbolButton(imageName: "xmark", imageSize: 17, imageColor: .black)
    let bluryBackground = UIView()
    
    var cast: Cast? { didSet {addCastViews(with: CastViewModel(cast!))} }
}

