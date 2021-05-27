//
//  NutritionViewModel.swift
//  NutritionAppTZ
//
//  Created by Никита Коголенок on 22.05.21.
//

import UIKit

protocol NutritionViewModelProtocol {
    var caloriesGoalText: String { get }
    var burntCaloriesText: String { get }
    var eatingCaloriesText: String { get }
    var totalCaloriesText: String { get }
    
    var nutritionLineChartDataEntries: [PointEntry] { get }
    
    var breakfastInfoStateModel: MealCategoryInfoViewStateModel { get }
    var lunchInfoStateModel: MealCategoryInfoViewStateModel { get }
    var dinnerInfoStateModel: MealCategoryInfoViewStateModel { get }
    
    func bind(_ view: NutritionViewProtocol)
}

class NutritionViewModel: NutritionViewModelProtocol {
    private weak var view: NutritionViewProtocol?
    
    private var breakfastMeal: MealCategory?
    private var lunchMeal: MealCategory?
    private var dinnerMeal: MealCategory?
    
    private let caloriesGoalCalories: Int = 1450
    private let burntCalories: Int = 90
    private var eatingCalories: Int {
        let breakfastCalories = breakfastMeal?.calorieCount ?? 0
        let lunchCalories = lunchMeal?.calorieCount ?? 0
        let dinnerCalories = dinnerMeal?.calorieCount ?? 0
        return Int(breakfastCalories + lunchCalories + dinnerCalories)
    }
    
    private var totalCalories: Int {
        return eatingCalories - burntCalories
    }
    
    var caloriesGoalText: String {
        return "\(caloriesGoalCalories) kcal"
    }
    
    var burntCaloriesText: String {
        return "\(burntCalories) kcal"
    }
    
    var eatingCaloriesText: String {
        return "\(eatingCalories) kcal"
    }
    
    var totalCaloriesText: String {
        return "\(totalCalories)"
    }
    
    var breakfastInfoStateModel: MealCategoryInfoViewStateModel {
        return MealCategoryInfoViewStateModel(
            mealCategory: breakfastMeal,
            plusButtonPressedAction: { [weak self] in
                guard let self = self,
                      let breakfaskMeal = self.breakfastMeal
                else { return }
                self.handlePlusButtonPressed(mealCategory: breakfaskMeal)
            })
    }
    
    var lunchInfoStateModel: MealCategoryInfoViewStateModel {
        return MealCategoryInfoViewStateModel(
            mealCategory: lunchMeal,
            plusButtonPressedAction: { [weak self] in
                guard let self = self,
                      let lunchMeal = self.lunchMeal
                else { return }
                self.handlePlusButtonPressed(mealCategory: lunchMeal)
            })
    }
    
    var dinnerInfoStateModel: MealCategoryInfoViewStateModel {
        return MealCategoryInfoViewStateModel(
            mealCategory: dinnerMeal,
            plusButtonPressedAction: { [weak self] in 
                guard let self = self,
                      let dinnerMeal = self.dinnerMeal
                else { return }
                self.handlePlusButtonPressed(mealCategory: dinnerMeal)
            })
    }
    
    var nutritionLineChartDataEntries: [PointEntry] {
        var pointEnties: [PointEntry] = []
        /// Add breakfast in vector
        pointEnties.append(PointEntry(value: 0, label: ""))
        let breakfaskValue: Int = Int(breakfastMeal?.calorieCount ?? 0)
        let breakfastLabel: String = "\(breakfastMeal?.calorieCount ?? 0)"
        pointEnties.append(
            PointEntry(value: breakfaskValue, label: breakfastLabel))
        /// Add lunch in vector
        pointEnties.append(PointEntry(value: 0, label: ""))
        let lunchValue: Int = Int(lunchMeal?.calorieCount ?? 0)
        let lunchLabel: String = "\(lunchMeal?.calorieCount ?? 0)"
        pointEnties.append(
            PointEntry(value: lunchValue, label: lunchLabel))
        /// Add dinner in vector
        pointEnties.append(PointEntry(value: 0, label: ""))
        let dinnerValue: Int = Int(dinnerMeal?.calorieCount ?? 0)
        let dinnerLabel: String = "\(dinnerMeal?.calorieCount ?? 0)"
        pointEnties.append(
            PointEntry(value: dinnerValue, label: dinnerLabel))
        
        pointEnties.append(PointEntry(value: 0, label: ""))
        return pointEnties
    }
    
    init() {
        DatabaseService.shared.entitiesFor(type: MealCategory.self, context: Constants.mainObjectContext) { [weak self] (mealCategories) in
            guard let self = self else { return }
            /// Breakfast
            var breakfastCategory = mealCategories.first { (category) -> Bool in
                return category.type == MealCalorieType.breakfast.rawValue
            }
            if breakfastCategory == nil {
                breakfastCategory = MealCategory(context: Constants.mainObjectContext)
                breakfastCategory?.type = MealCalorieType.breakfast.rawValue
            }
            self.breakfastMeal = breakfastCategory
            /// Lunch
            var lunchCategory = mealCategories.first { (category) -> Bool in
                return category.type == MealCalorieType.lunch.rawValue
            }
            if lunchCategory == nil {
                lunchCategory = MealCategory(context: Constants.mainObjectContext)
                lunchCategory?.type = MealCalorieType.lunch.rawValue
            }
            self.lunchMeal = lunchCategory
            /// Dinner
            var dinnerCategory = mealCategories.first { (category) -> Bool in
                return category.type == MealCalorieType.binner.rawValue
            }
            if dinnerCategory == nil {
                dinnerCategory = MealCategory(context: Constants.mainObjectContext)
                dinnerCategory?.type = MealCalorieType.binner.rawValue
            }
            self.dinnerMeal = dinnerCategory
            self.view?.update()
        }
    }
    
    func bind(_ view: NutritionViewProtocol) {
        self.view = view
        view.update()
    }
    
    func handlePlusButtonPressed(mealCategory: MealCategory) {
        view?.showAddCategories(completion: { [weak self] calories in
            mealCategory.calorieCount = Int16(calories)
            mealCategory.date = Date()
            DatabaseService.shared.saveMain()
            self?.view?.update()
        })
    }
}
