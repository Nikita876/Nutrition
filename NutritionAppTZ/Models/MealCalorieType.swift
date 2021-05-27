//
//  MealCalorieType.swift
//  NutritionAppTZ
//
//  Created by Никита Коголенок on 22.05.21.
//

import Foundation

enum MealCalorieType: String {
    case breakfast
    case lunch
    case binner
    
    var description: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .binner:
            return "Binner"
        }
    }
}
