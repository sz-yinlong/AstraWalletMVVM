//
//  DetailsViewController.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 23.03.2023.
//

import Foundation

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var coin: CoinDetails!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientBackground()

        
        configureTableView()
        title = coin.name
  
    }
    
    private func configureGradientBackground() {
        let gradientView = GradientView(frame: view.bounds)
        view.insertSubview(gradientView, at: 0)
    }

    // MARK: - TableView
    
    

    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.borderWidth = 2
        tableView.layer.cornerRadius = 20
        tableView.layer.borderColor   = UIColor.systemPink.cgColor
        
       
        

        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 15/255, green: 29/255, blue: 52/255, alpha: 1).cgColor,
            UIColor(red: 21/255, green: 46/255, blue: 86/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = view.bounds
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradient, at: 0)
        tableView.backgroundView = backgroundView
        
       

        tableView.clipsToBounds = true

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 6
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
      
        switch section {
        case 0:
            return "Basic Info"
        case 1:
            return "Market Info"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Symbol: \(coin.symbol)"
            case 1:
                cell.textLabel?.text = "Rank: \(coin.marketcap.rank)"
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Price USD: \(formattedPrice(coin.market_data.price_usd))"
            case 1:
                cell.textLabel?.text = "Change 24H: \(formattedChangePercent(Double(coin.market_data.percent_change_usd_last_24_hours)))"
            case 2:
                cell.textLabel?.text = "Market Cap: \(formattedMarketCap(coin.marketcap.current_marketcap_usd))"
            case 3:
                cell.textLabel?.text = "Volume 24H: \(formattedVolume(coin.market_data.volume_last_24_hours))"
            case 4:
                cell.textLabel?.text = "Supply: \(formattedSupply(coin.supply.circulating))"
            case 5:
                cell.textLabel?.text = "Max Supply: \(formattedMaxSupply(coin.supply.y_2050))"
            default:
                break
            }
        default:
            break
        }

        return cell

    }




    private func formattedPrice(_ value: Double?) -> String {
        guard let value = value else {
            return "N/A"
        }
        let roundedPrice = round(value * 10) / 10
        let formattedPrice = "$\(String(format: "%.2f", roundedPrice))"
        print("Formatted price: \(formattedPrice)")
        return formattedPrice
    }

    private func formattedChangePercent(_ value: Double?) -> String {
        guard let value = value else {
            return "N/A"
        }
        let roundedValue = round(value * 10) / 10
        return "\(String(format: "%.1f", roundedValue))%"
    }

    private func formattedMarketCap(_ value: Double?) -> String {
        guard let value = value else {
            return "N/A"
        }

        let numberFormatter = NumberFormatter()

        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0

        let formattedValue = numberFormatter.string(from: NSNumber(value: value)) ?? "N/A"

        return formattedValue
    }

    private func formattedSupply(_ value: Double?) -> String {
        guard let value = value else {
            return "N/A"
        }

        let numberFormatter = NumberFormatter()

        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0

        let formattedValue = numberFormatter.string(from: NSNumber(value: value)) ?? "N/A"

        return formattedValue
    }

    private func formattedMaxSupply(_ value: Double?) -> String {
        guard let value = value else {
            return "N/A"
        }

        let numberFormatter = NumberFormatter()

        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0

        let formattedValue = numberFormatter.string(from: NSNumber(value: value)) ?? "N/A"

        return formattedValue
    }

    private func formattedVolume(_ value: Double?) -> String {
        guard let value = value, let doubleValue = Double?(value) else {
            return "N/A"
        }

        let numberFormatter = NumberFormatter()

        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0

        let formattedValue = numberFormatter.string(from: NSNumber(value: doubleValue)) ?? "N/A"

        return formattedValue
    }

}
