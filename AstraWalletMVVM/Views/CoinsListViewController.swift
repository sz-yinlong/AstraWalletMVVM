//CoinsListViewController.swift
//AstraWallet MVVM


import Combine
import UIKit

class CoinsListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var cancellables = Set<AnyCancellable>()
    let viewModel = CoinsListViewModel()
    private let loginVM = LoginViewModel.shared
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCoins()
        
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        title = "ASTRA WALLET"
        navigationItem.hidesBackButton = true
        configureGradientBackground()
        configureTableView()
        configureLogoutButton()
        configureActivityIndicator()
    }
    
    private func configureGradientBackground() {
        let gradientView = GradientView(frame: view.bounds)
        view.insertSubview(gradientView, at: 0)
    }
    
    private func configureTableView() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.stopAnimating()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureActivityIndicator() {
        activityIndicator.color = .systemPink
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureLogoutButton() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func bindViewModel() {
        viewModel.$coins
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        loginVM.$isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                if !isLoggedIn {
                    self?.showLoginScreen()
                }
            }
            .store(in: &cancellables)
    }
    
    private func showLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    private func handleLoginStatusChange(isLoggedIn: Bool) {
        if isLoggedIn {
            viewModel.fetchCoins()
            tableView.reloadData()
        } else {
            loginVM.logout()
        }
    }
    
    @objc private func logout() {
        loginVM.logout()
    }
}
