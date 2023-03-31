
//CoinInfoModel.swift
//
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 08.03.2023.




import Foundation



struct CoinInfo: Codable {

    let data: CoinDetails
}


struct CoinDetails: Codable {

    let symbol: String
    let name: String
    let market_data: MarketData
    let marketcap: MarketCap
    let supply: Supply

}

struct MarketData: Codable {
    let price_usd: Double
    let volume_last_24_hours: Double
    let percent_change_usd_last_1_hour: Double
    let percent_change_usd_last_24_hours: Double

}



struct MarketCap: Codable {
    let rank: Int
    let current_marketcap_usd: Double

}

struct Supply: Codable {


    let y_2050: Double
    let circulating: Double

}

struct Status: Decodable {
    let elapsed: Int
    let timestamp: String
    let error_code: Int
    let error_message: String
}
