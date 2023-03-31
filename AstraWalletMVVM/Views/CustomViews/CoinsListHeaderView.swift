//
//  CoinsListHeaderView.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 17.03.2023.
//


import UIKit

//class CoinsListHeaderView: UIView {
//
//    var onSortButtonTapped: (() -> Void)?
//
//    override init(frame: CGRect) {
//        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 27))
//
//        setupHeaderView()
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupHeaderView() {
//        self.backgroundColor = .systemPink
//        self.alpha = 0.8
//
//        let rankLabel = UILabel(frame: CGRect(x: 15, y: 5, width: 20, height: 20))
//        rankLabel.text = "#"
//        self.addSubview(rankLabel)
//
//        let nameLabel = UILabel(frame: CGRect(x: 40, y: 5, width: 40, height: 20))
//        nameLabel.text = "coin"
//
//        self.addSubview(nameLabel)
//
//        let priceLabel = UILabel(frame: CGRect(x: 160, y: 5, width: 40, height: 20))
//        priceLabel.text = "price"
//
//        self.addSubview(priceLabel)
//
//        let sortButton = UIButton()
//                let symbolConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
//                let image = UIImage(systemName: "arrow.up.arrow.down")?.withConfiguration(symbolConfig)
//                sortButton.tintColor = .white
//                sortButton.layer.borderWidth = 1
//                sortButton.layer.borderColor = UIColor.white.cgColor
//                sortButton.layer.cornerRadius = 8
//                sortButton.setImage(image, for: .normal)
//
//                sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
//
//
//                self.addSubview(sortButton)
//                sortButton.translatesAutoresizingMaskIntoConstraints = false
//
//
//                NSLayoutConstraint.activate([
//                    sortButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                    sortButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -120),
//                    sortButton.widthAnchor.constraint(equalToConstant: 38),
//                    sortButton.heightAnchor.constraint(equalToConstant: 28)
//                ])
//
//
//
//        let marketCapLabel = UILabel(frame: CGRect(x: 290, y: 5, width: 80, height: 20))
//        marketCapLabel.text = "market cap"
//
//        self.addSubview(marketCapLabel)
//
//
//        for case let label as UILabel in self.subviews {
//            label.textColor = .white
//            label.font = .boldSystemFont(ofSize: 12)
//        }
//
//    }
//    @objc private func sortButtonTapped() {
//           onSortButtonTapped?()
//       }
//}



class CoinsListHeaderView: UIView {

    var onSortButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 27))

        setupHeaderView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHeaderView() {
        self.backgroundColor = .systemPink
        self.alpha = 0.8

        let rankLabel = UILabel()
        rankLabel.text = "#"
        rankLabel.textColor = .white
        rankLabel.font = .boldSystemFont(ofSize: 12)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rankLabel)
        
        let nameLabel = UILabel()
        nameLabel.text = "coin"
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 12)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        let priceLabel = UILabel()
        priceLabel.text = "price"
        priceLabel.textColor = .white
        priceLabel.font = .boldSystemFont(ofSize: 12)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(priceLabel)

        let sortButton = UIButton()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
        let image = UIImage(systemName: "arrow.up.arrow.down")?.withConfiguration(symbolConfig)
        sortButton.tintColor = .white
        sortButton.layer.borderWidth = 1
        sortButton.layer.borderColor = UIColor.white.cgColor
        sortButton.layer.cornerRadius = 8
        sortButton.setImage(image, for: .normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        addSubview(sortButton)

        let marketCapLabel = UILabel()
        marketCapLabel.text = "market cap"
        marketCapLabel.textColor = .white
        marketCapLabel.font = .boldSystemFont(ofSize: 12)
        marketCapLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(marketCapLabel)

        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            rankLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 25),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            priceLabel.trailingAnchor.constraint(equalTo: sortButton.leadingAnchor, constant: -40),
            priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            sortButton.trailingAnchor.constraint(equalTo: marketCapLabel.leadingAnchor, constant: -40),
            sortButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sortButton.widthAnchor.constraint(equalToConstant: 38),
            sortButton.heightAnchor.constraint(equalToConstant: 28),

            marketCapLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            marketCapLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    @objc private func sortButtonTapped() {
        onSortButtonTapped?()
    }
}
