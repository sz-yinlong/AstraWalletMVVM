//
//  LoginViewModel.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 17.03.2023.
//
import Combine
import Foundation
import UIKit






class LoginViewModel {
    static let shared = LoginViewModel()
    let loginSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoggedIn: Bool = false

    private let requiredUsername = "1234"
    private let requiredPassword = "1234"
    
    init() {
          if let username = UserDefaults.standard.string(forKey: "username"),
              let password = UserDefaults.standard.string(forKey: "password") {
              performLogin(username: username, password: password)
          }
      }

    
    func performLogin(username: String, password: String) {
        if username == requiredUsername && password == requiredPassword {
            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(password, forKey: "password")
            isLoggedIn = true
            loginSubject.send()
        } else {
            isLoggedIn = false
            
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")
        isLoggedIn = false
        
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = navController
    }

}
