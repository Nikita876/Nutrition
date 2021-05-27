//
//  DateFormatter+Extension.swift
//  NutritionAppTZ
//
//  Created by Никита Коголенок on 22.05.21.
//

import Foundation

extension DateFormatter {
    static let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }()
}
