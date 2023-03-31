//
//  LimitResponse.swift
//  AstraWalletMVVM
//
//  Created by Artem Bariev on 25.03.2023.
//

import Foundation

struct ApiResponse: Codable {
    struct Status: Codable {
        let elapsed: Int
        let timestamp: String
        let errorCode: Int
        let errorMessage: String
        
        enum CodingKeys: String, CodingKey {
            case elapsed
            case timestamp
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
    }
    
    let status: Status
}
