//
//  GradientView.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 17.03.2023.
//

import UIKit

class GradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 15/255, green: 29/255, blue: 52/255, alpha: 1).cgColor,
            UIColor(red: 21/255, green: 46/255, blue: 86/255, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
