//
//  CoinsListViewModel.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 17.03.2023.


import Foundation
import Combine

class CoinsListViewModel {
    
    @Published var coins: [CoinDetails] = []
    @Published var sortCriteria: SortCriteria = .priceChangeUSD
    @Published var isLoading: Bool = false
    
    private var sortOrderIsAscending = true
    
    var cancellables = Set<AnyCancellable>()
    
    private var cancellationToken: DispatchWorkItem?
    
    
    func fetchCoins() {
        isLoading = true
        getCoinDetails()
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] coins in
                self?.coins = coins
                self?.isLoading = false
                
            })
        
            .store(in: &cancellables)
    }
    
    
    
    func getCoinDetails() -> AnyPublisher<[CoinDetails], Error> {
        
        let coins = ["BTC", "ETH", "ADA", "DOGE", "XRP", "DOT", "BNB", "SOL", "UNI", "LTC"]
        guard let baseURL = URL(string: "https://data.messari.io/api/v1/assets") else { return Empty<[CoinDetails], Error>()
            .eraseToAnyPublisher() }
        
        let coinDetailsPublisher = coins.map { coin in
        let url = baseURL.appendingPathComponent(coin).appendingPathComponent("metrics")
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: CoinInfo.self, decoder: JSONDecoder())
                .map { coinDetails in
                    print("Received response for \(coin): \(coinDetails)")
                    return coinDetails.data
                }
                .eraseToAnyPublisher()
        }
        
        return Publishers.MergeMany(coinDetailsPublisher)
        
            .collect()
            .eraseToAnyPublisher()
    }
    
    //MARK: - Sorting section
    
    
    
            func sortButtonTapped() {
                sortOrderIsAscending.toggle()
                if sortOrderIsAscending {
                    coins.sort { $0.market_data.percent_change_usd_last_24_hours > $1.market_data.percent_change_usd_last_24_hours }
                } else {
                    coins.sort { $0.marketcap.current_marketcap_usd > $1.marketcap.current_marketcap_usd}
                }
            }
}
    
        
        enum SortCriteria {
            case priceChangeUSD
            case marketCap
        }
        
