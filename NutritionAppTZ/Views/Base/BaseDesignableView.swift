//
//  BaseDesignableView.swift
//  NutritionAppTZ
//
//  Created by Никита Коголенок on 22.05.21.
//
import UIKit

class BaseDesignableView: UIView {
    private var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: classForCoder)
        let nibName = String(describing: classForCoder)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

