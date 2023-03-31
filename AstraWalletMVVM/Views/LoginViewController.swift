//
//  LoginViewController.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 17.03.2023.
//

import UIKit
import Combine

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private let loginTextField = LoginTextField()
    private let passwordTextField = PasswordTextField()
    private let loginButton = LoginButton()
    private let viewModel = LoginViewModel.shared
    private var cancellables = Set<AnyCancellable>()
   
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleLabel()
        configureGradientBackground()
        configureLoginTextField()
        configurePasswordTextField()
        configureLoginButton()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        setupBindings()
  
        
       
    }
    
    private func configureGradientBackground() {
        let gradientView = GradientView(frame: view.bounds)
        view.insertSubview(gradientView, at: 0)
    }

    
    private func setupBindings() {
        viewModel.loginSubject
            .sink { [weak self] _ in
                guard let strongSelf = self else { return }
                let coinsListVC = CoinsListViewController()
                if let navigationController = strongSelf.navigationController {
                    DispatchQueue.main.async {
                        navigationController.pushViewController(coinsListVC, animated: true)
                    }
                }
            }
            .store(in: &cancellables)
    }

        @objc private func loginButtonTapped() {
            let username = loginTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            viewModel.performLogin(username: username, password: password)
            //setup the viewcontroller after login is tapped
        }
    
    
    
    
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 50)
        
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .systemPink
        titleLabel.clipsToBounds = true
        titleLabel.text = "AstraWallet"
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 145),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
  
    
    private func configureLoginTextField() {
        
        loginTextField.delegate = self
        
        view.addSubview(loginTextField)
        
        NSLayoutConstraint.activate([
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            loginTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configurePasswordTextField() {
        
        passwordTextField.delegate = self
        
        
        
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor,constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private    func configureLoginButton() {
        
        
        
        
        view.addSubview(loginButton)
        
        
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 200),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()

        
        loginButtonTapped()

        return true
    }
}
