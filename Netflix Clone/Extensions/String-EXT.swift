//
//  String-EXT.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 25/02/2024.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func extract() -> (month: String, day: String, dayMonth: String, year: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-dd"
        
        guard let date = dateFormatter.date(from: self) else {return (month: "N/A", day: "N/A", dayMonth: "N/A", year: "N/A")}
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let year = yearFormatter.string(from: date)
        
        let monthNameFormatter = DateFormatter()
        monthNameFormatter.dateFormat = "MMMM"
        let month = monthNameFormatter.string(from: date)
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        let day = dayFormatter.string(from: date)
        
        let shortMonthFormatter = DateFormatter()
        shortMonthFormatter.dateFormat = "MMM"
        let shortMonth = shortMonthFormatter.string(from: date).uppercased()
        
        let dayMonth = "\(day) \(month)"
        
        return (month: shortMonth, day: day, dayMonth: dayMonth, year: year )
    }
    
    func whenItBeLiveText(modelFullDate fullDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-M-dd"
        let nowDate = Date.now
        
        guard let inputDate = dateFormatter.date(from: fullDate) else {
            return "Invalid Date"
        }
        
        if inputDate > nowDate {
            return "Coming on \(self)"
        } else {
            return "Now playing in cinemas"
        }
    }
    
    func isNewRelease() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-dd"
        
        if let releaseDate = dateFormatter.date(from: self) {
            let currentDate = Date()
            let calendar = Calendar.current
            
            if let daysDifference = calendar.dateComponents([.day], from: releaseDate, to: currentDate).day {
                return daysDifference <= 30
            }
        }
        
        return false
    }
    
}

