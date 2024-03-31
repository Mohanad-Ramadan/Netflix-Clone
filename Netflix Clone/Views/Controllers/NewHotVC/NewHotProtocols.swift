//
//  NewHotProtocols.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 07/12/2023.
//

import UIKit


extension NewHotVC: UITableViewDelegate,
                    UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entertainments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewAndHotTableViewCell.identifier, for: indexPath) as? NewAndHotTableViewCell else {return UITableViewCell()}
        let entertainment = entertainments[indexPath.row]
        setDataSource(for: cell, from: entertainment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let media = entertainments[indexPath.row]
        let isTrend = self.isTheTappedMediaTrend!
        let trendRank = indexPath.row+1
        
        if media.mediaType == nil || media.mediaType == "movie" {
            let vc = MovieDetailsVC(for: media, isTrend: isTrend, rank: trendRank)
            presentAsRoot(vc)
        } else {
            let vc = TVDetailsVC(for: media, isTrend: isTrend, rank: trendRank)
            presentAsRoot(vc)
        }
    }
        
}
