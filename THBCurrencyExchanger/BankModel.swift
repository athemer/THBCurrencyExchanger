//
//  BankModel.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/26.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift


class BankModel: Object {
    
    dynamic var bankModelId: String = ""
    dynamic var bankName: String!
    dynamic var bankBranch: String?

    var coordinate = List<LocationModel>()
    
    dynamic var buyingTWD: String?
    dynamic var buyingUSD: String?
    dynamic var sellingTHB: String?
    dynamic var sellingUSD: String?


    override static func primaryKey() -> String? {
        return "bankModelId"
    }


}
