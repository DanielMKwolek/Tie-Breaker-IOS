//
//  CoinFlipper.swift
//  Tie Breaker
//
//  Created by Daniel Kwolek on 1/28/19.
//  Copyright © 2019 Daniel Kwolek. All rights reserved.
//

import UIKit

enum CoinFlip: String {
    case heads = "heads"
    case tails = "tails"
}


class CoinFlipper: NSObject, NSCoding {
    private var _flips: [String]
    public var coinFlips: [CoinFlip] {
            var array: [CoinFlip] = []
            for flip in self._flips {
                if let _flip = CoinFlip(rawValue: flip) {
                array.append(_flip)
                }
            }
            return array
    }
    
    public var heads: Int {
        var h = 0
        for flip in _flips {
            if flip == CoinFlip.heads.rawValue {
                h = h + 1
            }
        }
        return h
    }
    
    public var tails: Int {
        var t = 0
        for flip in _flips {
            if flip == CoinFlip.tails.rawValue {
                t = t + 1
            }
        }
        return t
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_flips, forKey: "flips")
    }
    
    init(flips: [String]) {
        self._flips = []
        for string in flips {
            if (string == CoinFlip.heads.rawValue || string == CoinFlip.tails.rawValue) {
                self._flips.append(string)
            }
        }
    }
    
    func flip( ntimes: inout Int) {
        while ntimes > 0 {
            _flips.append(generateCoinFlip())
            ntimes = ntimes - 1
        }
        saveData()
    }
    
    func clearFlips() {
        _flips = []
        saveData()
    }
    
    private func saveData() {
        NSKeyedArchiver.archiveRootObject(self, toFile: CoinFlipper.filePath)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let flips = aDecoder.decodeObject(forKey: "flips") as? [String] else {return nil}
        self.init(flips: flips)
    }
    
    private func generateCoinFlip() -> String {
        let i = arc4random() % 2
        if i == 1 {
            return CoinFlip.heads.rawValue
        } else {
            return CoinFlip.tails.rawValue
        }
    }
    
    static var filePath: String {
        //1 - manager lets you examine contents of a files and folders in your app; creates a directory to where we are saving it
        let manager = FileManager.default
        //2 - this returns an array of urls from our documentDirectory and we take the first path
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        print("this is the url path in the documentDirectory \(url?.absoluteString ?? "stringError")")
        //3 - creates a new path component and creates a new file called "Data" which is where we will store our Data array.
        return (url!.appendingPathComponent("coinFlipViewControllerData").path)
    }
}
