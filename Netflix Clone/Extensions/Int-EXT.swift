//
//  Int-EXT.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/02/2024.
//

import Foundation

extension Int {
    
    func formatTimeFromMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        if hours > 0 {
            return String(format: "%dh %02dm", hours, minutes)
        } else {
            return String(format: "%dm", minutes)
        }
    }
    
}

