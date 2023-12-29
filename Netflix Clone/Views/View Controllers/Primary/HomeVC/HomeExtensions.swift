//
//  HomeVCDelegateExtension.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 04/12/2023.
//

import UIKit



extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        embedSections(sectionNumbs: indexPath.section, cell: cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.sectionHeaderTopPadding = 40
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 19, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.text = sectionTitles[section]
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 9),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -5)
        ])
        
        return headerView
    }
    
}

//MARK: - TableView Sections

enum Sections: Int {
    case  TopSeries = 0, TrendingTVNow = 1 , PopularMovies = 2, TrendingMoviesNow = 3, UpcomingMovies = 4
}

func embedSections(sectionNumbs: Int, cell: HomeTableViewCell){
    switch sectionNumbs{
    case Sections.TopSeries.rawValue:
        APICaller.shared.getTopSeries { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.TrendingTVNow.rawValue:
        APICaller.shared.getTrendingTV { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.PopularMovies.rawValue:
        APICaller.shared.getPopular { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.TrendingMoviesNow.rawValue:
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    case Sections.UpcomingMovies.rawValue:
        APICaller.shared.getUpcomingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    default:
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let entertainments):
                cell.configureCollection(with: entertainments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
