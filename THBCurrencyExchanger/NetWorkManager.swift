//
//  NetWorkManager.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/26.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation
import Kanna
import Alamofire
import SwiftyJSON
import RealmSwift
import EZLoadingActivity


class NetWorkManager {


    let group = DispatchGroup()



    func scapeFinished() {


        group.notify(queue: .main) { 



        }


    }

    func scrapeTaianBank() -> Void {

        Alamofire.request("http://rate.bot.com.tw/xrt?Lang=zh-TW").responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseTaiwanBankHTML(html: html)
            }
        }
    }

    func scrapeBangkokBank() -> Void {

        Alamofire.request("http://www.bbl.com.tw/exrate.asp").responseString { response in
            print("check for true or false , \(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseBangkokBankHTML(html: html)
            }
        }
    }


    func scrapeSuperRichOrangeBr6()  {

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters: [String: Any] = [
            "lang": "th",
            "br_id": 6
        ]

        Alamofire.request(
            "http://www.superrich1965.com/ajax/getRateList.php",
            method: .post,
            parameters: parameters,
            encoding: URLEncoding.httpBody,
            headers: headers
            ).responseString { response in

                if let html = response.result.value {
                    self.parseSPOrangeBr6(html: html)
                }
        }
    }



    func scrapeSuperRichOrangeBr8()  {

//        EZLoadingActivity.show("更新匯率中", disableUI: false)

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters: [String: Any] = [
            "lang": "th",
            "br_id": 8
        ]

        Alamofire.request(
            "http://www.superrich1965.com/ajax/getRateList.php",
            method: .post,
            parameters: parameters,
            encoding: URLEncoding.httpBody,
            headers: headers
            ).responseString { response in



                if let html = response.result.value {
                    self.parseSPOrangeBr8(html: html)
                }


        }
    }


    func scrapeSuperRichGreen() -> Void {

        let headers = [
            "accept": "application/json, text/plain, */*",
            "accept-encoding": "gzip, deflate, br",
            "accept-language": "zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4",
            "authorization": "Basic c3VwZXJyaWNoVGg6aFRoY2lycmVwdXM=",
            "connection": "keep-alive",
            "content-type": "application/json",
            "host": "www.superrichthailand.com",
            "referer": "https://www.superrichthailand.com/",
            "x-access-token": "null",
            ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://www.superrichthailand.com/web/api/v1/rates")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {

                print(error)

            } else {


                let json = JSON(data: data!)

                let buyingUSDHead = json["data"]["exchangeRate"][0]["rate"][0]["cBuying"].floatValue

                let buyingTWDHead = json["data"]["exchangeRate"][13]["rate"][0]["cBuying"].floatValue

            }
        })

        dataTask.resume()

    }

    func parseTaiwanBankHTML(html: String) {

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {

            for rate in doc.xpath("/html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[3]") {

                print ("台灣銀行 泰銖賣匯", rate.text!)

            }
            
            //html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[2]

            for rate in doc.xpath("/html/body/div[1]/main/div[4]/table/tbody/tr[1]/td[3]") {

                print ("台灣銀行 美金賣匯", rate.text!)

            }
        }
    }

    func parseBangkokBankHTML(html: String) {

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {


            for rate in doc.xpath("//div[@id='container']/center/table/tr[6]/td[3]") {

                print ("盤谷銀行 泰銖賣匯", rate.text!)

            }

            for rate in doc.xpath("//div[@id='container']/center/table/tr[4]/td[3]") {

                print ("盤谷銀行 美金賣匯", rate.text!)

            }

        }
    }


    func parseSPOrangeBr8(html: String) {

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {


            let path = doc.xpath("//div[@class=\"row_rate\"]/div[@class=\"row\"]/div[@class =\"col-xs-3 text-right\"]")

            if path.count > 0 {

//                EZLoadingActivity.hide(true, animated: true)

                // 台幣買匯
                let buyingTWD = path[78].text!
                var buyingTWDRepalced = buyingTWD.replacingOccurrences(of: " ", with: "")
                buyingTWDRepalced.remove(at: buyingTWDRepalced.startIndex)

                print ("superRich 橘標分部『台幣』『買匯』", Float(buyingTWDRepalced)!)

                // 美金 100 元 買匯
                let buyingUSD = path[2].text!
                var buyingUSDRepalced = buyingUSD.replacingOccurrences(of: " ", with: "")
                buyingUSDRepalced.remove(at: buyingUSDRepalced.startIndex)

                print ("superRich 橘標分部『美金』『買匯』", Float(buyingUSDRepalced)!)



                let realm = try! Realm()
                let bankModel = BankModel()
                let coordinate = LocationModel()


                coordinate.locationId = "1"
                coordinate.longitude = "20.11111"
                coordinate.latitude = "123.21412"



                bankModel.bankModelId = "1"
                bankModel.bankName = "SuperRich Orange"
                bankModel.bankBranch = "總部"
                bankModel.buyingUSD = "\(buyingUSDRepalced)"
                bankModel.buyingTWD = "\(buyingTWDRepalced)"
//                bankModel.coordinate.append(coordinate)


//                user.name = "Sam"
//                user.age = 40
//                user.address = "Taipei"


                try! realm.write {
                    realm.add(bankModel, update: true)
                }



            }


        } else {

            print ("BRUH")

        }
    }

    func parseSPOrangeBr6(html: String) {

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {


            let path = doc.xpath("//div[@class=\"row_rate\"]/div[@class=\"row\"]/div[@class =\"col-xs-3 text-right\"]")

            if path.count > 0 {

                // 買匯
                let buyingTWD = path[78].text!
                var buyingTWDRepalced = buyingTWD.replacingOccurrences(of: " ", with: "")
                buyingTWDRepalced.remove(at: buyingTWDRepalced.startIndex)
                
                print ("superRich 橘標總部『台幣』『買匯』", Float(buyingTWDRepalced)!)
                
                // 賣匯
                let sellingTWD = path[79].text!
                var sellingTWDRepalced = sellingTWD.replacingOccurrences(of: " ", with: "")
                sellingTWDRepalced.remove(at: sellingTWDRepalced.startIndex)
                
                print ("superRich 橘標總部『台幣』『賣匯』", Float(sellingTWDRepalced)!)
                
                // 美金 100 元 買匯
                let buyingUSD = path[2].text!
                var buyingUSDRepalced = buyingUSD.replacingOccurrences(of: " ", with: "")
                buyingUSDRepalced.remove(at: buyingUSDRepalced.startIndex)
                
                print ("superRich 橘標總部『美金』『買匯』", Float(buyingUSDRepalced)!)

            }
            
            
        } else {
            
            print ("BRUH")
            
        }
    }

}
