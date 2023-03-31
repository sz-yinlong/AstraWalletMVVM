//
//  PasswordTextField.swift
//  AstraWallet
//
//  Created by Artem Bariev on 09.03.2023.
//



import UIKit

class PasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        isSecureTextEntry = true
        layer.cornerRadius  = 15
        layer.borderWidth   = 1
        layer.borderColor   = UIColor.systemGray4.cgColor
        
        adjustsFontSizeToFitWidth = true
        textColor       = .label
        tintColor       = .label
        textAlignment   = .center
        minimumFontSize = 12
        
        backgroundColor     = .tertiarySystemBackground
        autocorrectionType  = .no
        returnKeyType       = .go
        
        placeholder = "Password"
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}



