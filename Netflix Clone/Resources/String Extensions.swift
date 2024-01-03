//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 12/10/2023.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func extractMonthAndDay() -> (month: String, day: String, dayMonth: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-dd"

        guard let date = dateFormatter.date(from: self) else {return (month: "N/A", day: "N/A", dayMonth: "N/A")}
        
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
        
        return (month: shortMonth, day: day, dayMonth: dayMonth )
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
    
}
