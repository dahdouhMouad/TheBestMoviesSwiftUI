//
//  String.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation
extension String {
    func getYearFromDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        } else {
            return ""
        }
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

