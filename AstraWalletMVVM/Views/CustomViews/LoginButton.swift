//
//  LoginButton.swift
//  AstraWallet
//
//  Created by Artem Bariev on 09.03.2023.
//

import Foundation

import UIKit

class LoginButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 47/255, green: 138/255, blue: 245/255, alpha: 1)
        self.setTitle("Login", for: .normal)
        
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 15
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
