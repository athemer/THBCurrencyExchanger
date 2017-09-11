//
//  ExtensionString.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/9/9.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation

extension String {


    var toDouble: Double {

        get {

            return Double(self.replacingOccurrences(of: ",", with: ""))!

        }


    }



}
