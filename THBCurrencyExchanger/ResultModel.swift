//
//  ResultModel.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/9/2.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation

class ResultModel {

    var totalTWD: Double!
    var bankNameFirst: String!
    var bankNameSecond: String?
    var countryFirst: String!
    var countrySecond: String?
    var currencyRateFirst: Double!
    var currencyRateSecond: Double?
    var currencyNameFirst: String!
    var currencyNameSecond: String?
    var resultTHB: Double!


    init (totalTWD: Double,
          bankNameFirst:String,
          bankNameSecond:String?,
          countryFirst: String,
          countrySecond: String?,
          currencyNameFirst: String!,
          currencyNameSecond: String?,
          currencyRateFirst: Double,
          currencyRateSecond: Double?) {

        self.bankNameFirst = bankNameFirst
        self.bankNameSecond = bankNameSecond
        self.countryFirst = countryFirst
        self.countrySecond = countrySecond
        self.currencyNameFirst = currencyNameFirst
        self.currencyNameSecond = currencyNameSecond


        self.currencyRateFirst = currencyRateFirst

        self.currencyRateSecond = currencyRateSecond
        
        

        if currencyRateSecond != nil {

            self.resultTHB = totalTWD / currencyRateFirst * currencyRateSecond!

            
            print (" 用美金在泰國換匯 ", currencyRateFirst, currencyRateSecond!)
            

        } else {

            //計算結果應注意在泰國換匯或是在台灣換匯的問題
            if currencyRateFirst > 1 && currencyRateFirst < 20 {

                self.resultTHB = totalTWD * currencyRateFirst

                print ("僅在泰國換匯一次", currencyRateFirst, self.resultTHB)
                
            } else {
                
                self.resultTHB = totalTWD / currencyRateFirst
                
                print ("僅在台灣換匯一次", currencyRateFirst, self.resultTHB)
                
            }

        }
    }

}


class Calculator {

    func setUpModelArray(totalTWD: Double,
                         TWB_sellingTHB: Double,
                         TWB_sellingUSD: Double,
                         BKB_sellingTHB: Double,
                         SPO_Head_BuyingTWD: Double,
                         SPO_Head_BuyingUSD: Double,
                         SPO_Branch_BuyingTWD: Double,
                         SPO_Branch_BuyingUSD: Double,
                         SPG_Head_BuyingTWD: Double,
                         SPG_Head_BuyingUSD: Double) -> [ResultModel] {


        var array: [ResultModel]  = []

        let model_1 = ResultModel(totalTWD: totalTWD,
                                  bankNameFirst: "台灣銀行",
                                  bankNameSecond: nil,
                                  countryFirst: "台灣",
                                  countrySecond: nil,
                                  currencyNameFirst: "泰銖",
                                  currencyNameSecond: nil,
                                  currencyRateFirst: TWB_sellingTHB,
                                  currencyRateSecond: nil)

        let model_2 = ResultModel(totalTWD: totalTWD,
                                  bankNameFirst: "盤谷銀行",
                                  bankNameSecond: nil,
                                  countryFirst: "台灣",
                                  countrySecond: nil,
                                  currencyNameFirst: "泰銖",
                                  currencyNameSecond: nil,
                                  currencyRateFirst: BKB_sellingTHB,
                                  currencyRateSecond: nil)

        let model_3 = ResultModel(totalTWD: totalTWD,
                                  bankNameFirst: "SuperRich Orange 總部",
                                  bankNameSecond: nil,
                                  countryFirst: "泰國",
                                  countrySecond: nil,
                                  currencyNameFirst: "泰銖",
                                  currencyNameSecond: nil,
                                  currencyRateFirst: SPO_Head_BuyingTWD,
                                  currencyRateSecond: nil)

        let model_4 = ResultModel(totalTWD: totalTWD,
                                  bankNameFirst: "SuperRich Orange 分行",
                                  bankNameSecond: nil,
                                  countryFirst: "泰國",
                                  countrySecond: nil,
                                  currencyNameFirst: "泰銖",
                                  currencyNameSecond: nil,
                                  currencyRateFirst: SPO_Branch_BuyingTWD,
                                  currencyRateSecond: nil)

        let model_5 = ResultModel(totalTWD: totalTWD,
                                  bankNameFirst: "SuperRich Green 總部",
                                  bankNameSecond: nil,
                                  countryFirst: "泰國",
                                  countrySecond: nil,
                                  currencyNameFirst: "泰銖",
                                  currencyNameSecond: nil,
                                  currencyRateFirst: SPG_Head_BuyingTWD,
                                  currencyRateSecond: nil)

        let model_6 = ResultModel(totalTWD: totalTWD,
                                  bankNameFirst: "台灣銀行",
                                  bankNameSecond: "SuperRich Orange 總部",
                                  countryFirst: "台灣",
                                  countrySecond: "泰國",
                                  currencyNameFirst: "美金",
                                  currencyNameSecond: "泰銖",
                                  currencyRateFirst: TWB_sellingUSD,
                                  currencyRateSecond: SPO_Head_BuyingUSD)

        let model_7 = ResultModel(totalTWD: totalTWD,
                                  bankNameFirst: "台灣銀行",
                                  bankNameSecond: "SuperRich Orange 分行",
                                  countryFirst: "台灣",
                                  countrySecond: "泰國",
                                  currencyNameFirst: "美金",
                                  currencyNameSecond: "泰銖",
                                  currencyRateFirst: TWB_sellingUSD,
                                  currencyRateSecond: SPO_Branch_BuyingUSD)


        let model_8 = ResultModel(totalTWD: totalTWD,
                                  bankNameFirst: "台灣銀行",
                                  bankNameSecond: "SuperRich Green 分行",
                                  countryFirst: "台灣",
                                  countrySecond: "泰國",
                                  currencyNameFirst: "美金",
                                  currencyNameSecond: "泰銖",
                                  currencyRateFirst: TWB_sellingUSD,
                                  currencyRateSecond: SPG_Head_BuyingUSD)


        array.append(model_1)
        array.append(model_2)
        array.append(model_3)
        array.append(model_4)
        array.append(model_5)
        array.append(model_6)
        array.append(model_7)
        array.append(model_8)

        
        
        let sortedArray = array.sorted(by: { $0.resultTHB > $1.resultTHB})
        
        
        return sortedArray
        
    }




}
