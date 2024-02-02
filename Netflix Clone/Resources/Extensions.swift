//
//  Extensions&Protocols.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 12/10/2023.
//

import Foundation
import UIKit

//MARK: - String Extension
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


//MARK: - Int Extension
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


//MARK: - UIColor Extension
extension UIColor {
    static func dominantColor(from image: UIImage) -> UIColor? {
        guard let inputImage = CIImage(image: image) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]),
              let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: nil)
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
    }
}

