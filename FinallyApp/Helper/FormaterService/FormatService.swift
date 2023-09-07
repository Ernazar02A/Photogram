//
//  FormatService.swift
//  FinallyApp
//
//  Created by Ernazar on 7/9/23.
//

import Foundation
 
class FormatService {
    
    static let shared = FormatService()
    
    func stringToDate(dateString: String) -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from:dateString) else { return DateComponents() }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        return components
    }
    
    func monthText(monthNumber: Int?) -> String {
        guard let month = monthNumber else { return ""}
        switch month {
        case 1: return "Январь"
        case 2: return "Февраль"
        case 3: return "Март"
        case 4: return "Апрель"
        case 5: return "Май"
        case 6: return "Июнь"
        case 7: return "Июль"
        case 8: return "Август"
        case 9: return "Сентябрь"
        case 10: return "Октябрь"
        case 11: return "Ноябрь"
        default: return "Декабрь"
        }
    }
}
