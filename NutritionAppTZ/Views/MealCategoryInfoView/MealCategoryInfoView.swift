//
//  MealCategoryInfoView.swift
//  NutritionAppTZ
//
//  Created by Никита Коголенок on 22.05.21.
//

import UIKit

struct MealCategoryInfoViewStateModel {
    let time: String
    let calorieNumber: String
    let mealType: String
    let plusButtonPressedAction: (() -> ())?
    
    init(mealCategory: MealCategory?, plusButtonPressedAction: (() -> ())?) {
        
        if let date = mealCategory?.date {
            let timeString = DateFormatter.timeFormatter.string(from: date)
            time = timeString
        } else {
            time = ""
        }
        
        calorieNumber = "\(Int(mealCategory?.calorieCount ?? 0))"
        if let typeString = mealCategory?.type,
           let type = MealCalorieType(rawValue: typeString) {
            mealType = type.description.uppercased()
        } else {
            mealType = ""
        }
        
        self.plusButtonPressedAction = plusButtonPressedAction
    }
}

class MealCategoryInfoView: BaseDesignableView {
    // MARK: - Outlet
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var calorieNumberLabel: UILabel!
    @IBOutlet private weak var calorieLabel: UILabel!
    @IBOutlet private weak var mealCategoryLabel: UILabel!
    private var plusButtonPressedAction: (() -> ())?
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        calorieLabel.text = "kcal"
    }
    // MARK: Metods
    func setup(stateModel: MealCategoryInfoViewStateModel) {
        timeLabel.text = stateModel.time
        calorieNumberLabel.text = stateModel.calorieNumber
        mealCategoryLabel.text = stateModel.mealType
        plusButtonPressedAction = stateModel.plusButtonPressedAction
    }
    // MARK: - Action
    @IBAction func plusButtonPressed() {
        plusButtonPressedAction?()
    }
}
