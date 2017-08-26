//
//  LocationModel.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/26.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation
import RealmSwift


class LocationModel: Object {

    dynamic var locationId: String = ""
    dynamic var latitude: String = ""
    dynamic var longitude: String = ""


    override static func primaryKey() -> String? {
        return "locationId"
    }

}
