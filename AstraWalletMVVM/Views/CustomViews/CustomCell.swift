//
//  CustomCell.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 04.03.2023.
//

import Foundation


import UIKit

class CustomCell: UITableViewCell {

    // MARK: - Properties

    let rankLabel = UILabel()
    let symbolLabel = UILabel()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let changePercent24HrLabel = UILabel()
    let marketCapLabel = UILabel()


    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        rankLabel.font = UIFont.systemFont(ofSize: 14)
        rankLabel.textColor = .white
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.numberOfLines = 0
        rankLabel.textAlignment = .center
        contentView.addSubview(rankLabel)

        symbolLabel.font = UIFont.systemFont(ofSize: 12.0)
        symbolLabel.textColor = UIColor.systemGray.withAlphaComponent(0.6)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(symbolLabel)

        nameLabel.font = UIFont.systemFont(ofSize: 14.0)
        nameLabel.textColor = .white
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.8
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        priceLabel.font = UIFont.systemFont(ofSize: 14.0)
        priceLabel.textColor = .white
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.minimumScaleFactor = 0.8
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .right
        contentView.addSubview(priceLabel)

        changePercent24HrLabel.font = UIFont.systemFont(ofSize: 12)
        changePercent24HrLabel.adjustsFontSizeToFitWidth = true
        changePercent24HrLabel.minimumScaleFactor = 0.5
        changePercent24HrLabel.translatesAutoresizingMaskIntoConstraints = false
        changePercent24HrLabel.textAlignment = .center



        contentView.addSubview(changePercent24HrLabel)

        marketCapLabel.font = UIFont.systemFont(ofSize: 14.0)
        marketCapLabel.textColor = .white
        marketCapLabel.adjustsFontSizeToFitWidth = true //
        marketCapLabel.minimumScaleFactor = 0.5 //
        marketCapLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapLabel.textAlignment = .right
        contentView.addSubview(marketCapLabel)
        
       




        let rankLabelConstraints = [
            rankLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rankLabel.bottomAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            rankLabel.widthAnchor.constraint(equalToConstant: 20)
        ]

        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 10),

            nameLabel.widthAnchor.constraint(equalToConstant: 90)

        ]

        let symbolLabelConstraints = [
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            symbolLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 10),
            symbolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]

        let priceLabelConstraints = [
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            priceLabel.trailingAnchor.constraint(equalTo: changePercent24HrLabel.leadingAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(equalToConstant: 60)
        ]

        let changePercent24HrLabelConstraints = [
            changePercent24HrLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            changePercent24HrLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            changePercent24HrLabel.trailingAnchor.constraint(equalTo: marketCapLabel.leadingAnchor, constant: -6),
            changePercent24HrLabel.widthAnchor.constraint(equalToConstant: 60)
        ]

        let marketCapLabelConstraints = [
            marketCapLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            marketCapLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            marketCapLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            marketCapLabel.widthAnchor.constraint(equalToConstant: 100)
        ]



        NSLayoutConstraint.activate(rankLabelConstraints + nameLabelConstraints + symbolLabelConstraints + priceLabelConstraints + changePercent24HrLabelConstraints + marketCapLabelConstraints)




    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with asset: CoinDetails) {
        rankLabel.text = String(asset.marketcap.rank)
        symbolLabel.text = asset.symbol
        nameLabel.text = asset.name



        let price = asset.market_data.price_usd
        let roundedPrice = round(Double(price) * 10) / 10
        let formattedprice = String(format: "%.2f", roundedPrice)
        priceLabel.text = formattedprice

        let changePercent24Hr = asset.market_data.percent_change_usd_last_24_hours
        let roundedChangePercent24Hr = round(changePercent24Hr * 10) / 10
        let formattedChangePercent24Hr = String(format: "%.1f%%", roundedChangePercent24Hr)
        changePercent24HrLabel.text = formattedChangePercent24Hr

        let marketCap = asset.marketcap.current_marketcap_usd
        let marketCapDouble = Double(marketCap)
        let numberFormatter = NumberFormatter()

        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0

        let formattedMarketCap = numberFormatter.string(from: NSNumber(value: marketCapDouble)) ?? "0"

        marketCapLabel.text = formattedMarketCap


 //   MARK: - Coloring price chagne

        if let text = changePercent24HrLabel.text {
            if text.contains("-") {
                changePercent24HrLabel.textColor = .systemRed
            } else {
                changePercent24HrLabel.textColor = .systemGreen
            }
        }

    }

}

