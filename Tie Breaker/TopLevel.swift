//
//  TopLevel.swift
//  Tie Breaker
//
//  Created by Daniel Kwolek on 1/27/19.
//  Copyright © 2019 Daniel Kwolek. All rights reserved.
//

import Foundation

enum CoinFlip: String {
    case heads = "Heads"
    case tails = "Tails"
}

func generateCoinFlip() -> CoinFlip {
    let i = arc4random() % 2
    if i == 1 {
        return .heads
    } else {
        return .tails
    }
}
