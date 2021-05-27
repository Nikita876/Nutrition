//
//  MealCategory+CoreDataProperties.swift
//  NutritionAppTZ
//
//  Created by Никита Коголенок on 22.05.21.
//
//

import Foundation
import CoreData


extension MealCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealCategory> {
        return NSFetchRequest<MealCategory>(entityName: "MealCategory")
    }

    @NSManaged public var type: String?
    @NSManaged public var date: Date?
    @NSManaged public var calorieCount: Int16

}

extension MealCategory : Identifiable {

}
