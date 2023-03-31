//
//  CoinsListVC+TableView.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 17.03.2023.
//

import UIKit

let tableView = UITableView()
var didSelectCoin: ((CoinDetails) -> Void)?
var coinData: [CoinDetails] = [] {
    didSet {
        
        tableView.reloadData()
    }
}

extension CoinsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let coin = viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! CustomCell
        let coin = viewModel.coins[indexPath.row]
        let detailsVC = DetailsViewController()
        detailsVC.coin = coin
        detailsVC.modalPresentationStyle = .popover
        present(detailsVC, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CoinsListHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.onSortButtonTapped = { [weak self] in
          self?.viewModel.sortButtonTapped()
        }
        return headerView
    }
    
    
}
