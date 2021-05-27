//
//  NutritionViewController.swift
//  NutritionAppTZ
//
//  Created by Никита Коголенок on 22.05.21.
//

import UIKit

protocol NutritionViewProtocol: AnyObject {
    func update()
    func showAddCategories(completion: ((Int) -> ())?)
}

class NutritionViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet private weak var nutritionLabel: UILabel!
    
    @IBOutlet private weak var caloriesGoalTitleLabel: UILabel!
    @IBOutlet private weak var caloriesGoalValueLabel: UILabel!
    
    @IBOutlet private weak var eatingTitleLabel: UILabel!
    @IBOutlet private weak var eatingValueLabel: UILabel!
    
    @IBOutlet private weak var burntTitleLabel: UILabel!
    @IBOutlet private weak var burntValueLabel: UILabel!
    
    @IBOutlet private weak var totalTitleLabel: UILabel!
    @IBOutlet private weak var totalValueLabel: UILabel!
    
    @IBOutlet private weak var nutritionLineChart: LineChart!
    
    @IBOutlet private weak var breakfastInfoView: MealCategoryInfoView!
    @IBOutlet private weak var lunchInfoView: MealCategoryInfoView!
    @IBOutlet private weak var dinnerInfoView: MealCategoryInfoView!
    // MARK: - Variable
    var viewModel: NutritionViewModelProtocol = NutritionViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self)
        
        nutritionLineChart.isCurved = true
    }
}
// MARK: - NutritionViewController: NutritionViewProtocol
extension NutritionViewController: NutritionViewProtocol {
    // MARK: - Methods
    func update() {
        caloriesGoalValueLabel.text = viewModel.caloriesGoalText
        eatingValueLabel.text = viewModel.eatingCaloriesText
        burntValueLabel.text = viewModel.burntCaloriesText
        totalValueLabel.text = viewModel.totalCaloriesText
        nutritionLineChart.dataEntries = viewModel.nutritionLineChartDataEntries
        breakfastInfoView.setup(stateModel: viewModel.breakfastInfoStateModel)
        lunchInfoView.setup(stateModel: viewModel.lunchInfoStateModel)
        dinnerInfoView.setup(stateModel: viewModel.dinnerInfoStateModel)
    }
    
    func showAddCategories(completion: ((Int) -> ())?) {
        let alertController = UIAlertController(title: "Enter Calories", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter Calories"
            textField.keyboardType = .numberPad
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            guard let textField = alertController.textFields?.first,
                  let text = textField.text
            else { return }
            let catigory = Int(text) ?? 0
            completion?(catigory)
        })
        
        let canselAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(canselAction)
        
        present(alertController, animated: true, completion: nil)
    } 
}
