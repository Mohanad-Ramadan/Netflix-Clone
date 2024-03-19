//
//  MovieDetailsVC.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 19/03/2024.
//

import UIKit

class MovieDetailsVC: EntertainmentDetailsVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        containterScrollView.addSubview(trailerTable)
        trailerTable.delegate = self
        trailerTable.dataSource = self
    }
    
    //MARK: - Videos Configuration
    private func getFirstTrailerName(from videosResult: [Trailer.Reuslts]) -> String {
        let trailerInfo = videosResult.filter { "Trailer".contains($0.type) }
        let trialerQuery = trailerInfo.map { $0.name }[0]
        return trialerQuery
    }
    
    func configureVideos(with model: MovieViewModel){
        // Trailer Configuration
//        guard let videosResult = model.videosResult else {return}
//        guard let entertainmentName = model.title else {return}
//
//        let trialerVideoQuery = "\(entertainmentName) \(getFirstTrailerName(from: videosResult))"
//
//        NetworkManager.shared.getYoutubeVideos(query: trialerVideoQuery) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let videoId):
//                    guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else {
//                        fatalError("can't get the youtube trailer url")
//                    }
//                    self.entertainmentTrailer.load(URLRequest(url: url))
//                case .failure(let failure):
//                    print("Error getting Trailer video:", failure)
//                }
//            }
//        }
//
//        // pass th videos without the one taken for the entertainmentTrailer webView
//        trailers = videosResult.filter { $0.name != getFirstTrailerName(from: videosResult) }
//        trailerVideosCount = trailers.count
    }
    
    //MARK: - Dynamic Constraints
    private func switchedViewsLayout(){
        // More CollectionView Constriants
        let moreIdeasCollectionConstriants = [
            moreIdeasCollection.topAnchor.constraint(equalTo: viewSwitchButtons.bottomAnchor),
            moreIdeasCollection.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
            moreIdeasCollection.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor, constant: -5),
            moreIdeasCollection.heightAnchor.constraint(equalToConstant: 430),
            moreIdeasCollection.bottomAnchor.constraint(equalTo: containterScrollView.bottomAnchor)
        ]
        // Trailer TableView Constriants
        let trailerTableConstriants = [
            trailerTable.topAnchor.constraint(equalTo: viewSwitchButtons.bottomAnchor),
            trailerTable.leadingAnchor.constraint(equalTo: entertainmentTrailer.leadingAnchor, constant: 5),
            trailerTable.trailingAnchor.constraint(equalTo: entertainmentTrailer.trailingAnchor,constant: -5),
            trailerTable.heightAnchor.constraint(equalToConstant: 290*CGFloat(trailerVideosCount ?? 0)),
            trailerTable.bottomAnchor.constraint(equalTo: containterScrollView.bottomAnchor),
        ]
        
        // Switching between views method
        switch viewSwitchButtons.selectedButtonView {
        case .moreIdeasView:
            // Add the CollectionView to the superView
            containterScrollView.addSubview(moreIdeasCollection)
            NSLayoutConstraint.activate(moreIdeasCollectionConstriants)
            // Remove the TableView from the SuperView
            trailerTable.removeFromSuperview()
            trailerTable.removeConstraints(moreIdeasCollectionConstriants)
        case .trailerView:
            // Add the TableView to the superView
            containterScrollView.addSubview(trailerTable)
            NSLayoutConstraint.activate(trailerTableConstriants)
            // Remove the TableView from the SuperView
            moreIdeasCollection.removeFromSuperview()
            moreIdeasCollection.removeConstraints(trailerTableConstriants)
        default:
            return
        }
    }
    
    override func applySwitchedViewsAndConstraints() {
        switchedViewsLayout()
        // Layout the views again
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.entertainmentVCKey), object: nil, queue: nil) { _ in
            self.switchedViewsLayout()
        }
    }
    
    //MARK: - Declare Movie Subviews
    private let trailerTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TrailersTableViewCell.self, forCellReuseIdentifier: TrailersTableViewCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .black
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var trailers: [Trailer.Reuslts] = [Trailer.Reuslts]()
    var trailerVideosCount: Int?
    var entertainmentName: String?
}
