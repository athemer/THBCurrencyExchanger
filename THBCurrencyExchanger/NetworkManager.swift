//
//  NetworkManager.swift
//  THBCurrencyExchanger
//
//  Created by kuanhuachen on 2017/8/24.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkManager {
    
    
    func isReachable() -> Bool {
        return (Alamofire.NetworkReachabilityManager()?.isReachable)!
    }
    
    
}
