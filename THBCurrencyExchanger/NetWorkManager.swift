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
import SCLAlertView


class NetWorkManager {


    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }


    let group = DispatchGroup()



    func scapeChain() {

        if isConnectedToInternet {

            EZLoadingActivity.show("更新匯率中", disableUI: true)


                self.testScrape()
                self.scrapeTaianBank()
                self.scrapeBangkokBank()
//                self.scrapeSuperRichOrangeBr6()
//                self.scrapeSuperRichOrangeBr8()
                self.scrapeSuperRichGreen()

                self.group.notify(queue: .main) {

                    EZLoadingActivity.hide(true, animated: true)

                }

        } else {

            self.showNotReachableAlert()
            
        }

    }



    func scrapeTaianBank() -> Void {

        group.enter()

        Alamofire.request("http://rate.bot.com.tw/xrt?Lang=zh-TW").responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseTaiwanBankHTML(html: html)
            }
        }
    }

    func scrapeBangkokBank() -> Void {

        group.enter()

        Alamofire.request("http://www.bbl.com.tw/exrate.asp").responseString { response in
            if let html = response.result.value {
                self.parseBangkokBankHTML(html: html)
            }
        }
    }


    func scrapeSuperRichOrangeBr6()  {

        group.enter()

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

        group.enter()

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

        group.enter()

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

                print (" @@@@@ get grenn rate ")



                let realm = try! Realm()
                let bankModel = BankModel()
                let coordinate = LocationModel()
                coordinate.locationId = "1"
                coordinate.longitude = "13.7398275"
                coordinate.latitude = "100.5377808"

                let coordinate2 = LocationModel()
                coordinate2.locationId = "1"
                coordinate2.longitude = "13.7398275"
                coordinate2.latitude = "100.5377808"

                let coordinate3 = LocationModel()
                coordinate3.locationId = "1"
                coordinate3.longitude = "13.7398275"
                coordinate3.latitude = "100.5377808"

                let coordinate4 = LocationModel()
                coordinate4.locationId = "1"
                coordinate4.longitude = "13.7398275"
                coordinate4.latitude = "100.5377808"


                bankModel.bankModelId = "5"
                bankModel.bankName = "SuperRich Green"
                bankModel.bankBranch = "Head"
                bankModel.buyingUSD = "\(buyingUSDHead)"
                bankModel.buyingTWD = "\(buyingTWDHead)"
                bankModel.coordinate.append(coordinate)

                try! realm.write {
                    realm.add(bankModel, update: true)

                    self.group.leave()

                }


            }
        })

        dataTask.resume()

    }

    func parseTaiwanBankHTML(html: String) {

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {


            var BU: String = ""

            var BT: String = ""

            for rate in doc.xpath("/html/body/div[1]/main/div[4]/table/tbody/tr[12]/td[3]") {

                BU = rate.text!

                print ("台灣銀行 泰銖賣匯", rate.text!)

            }

            for rate in doc.xpath("/html/body/div[1]/main/div[4]/table/tbody/tr[1]/td[3]") {

                BT = rate.text!

                print ("台灣銀行 美金賣匯", rate.text!)

            }

            let realm = try! Realm()
            let bankModel = BankModel()
            let coordinate = LocationModel()

            coordinate.locationId = "1"
            coordinate.longitude = "25.04147"
            coordinate.latitude = "121.5107233"

            bankModel.bankModelId = "1"
            bankModel.bankName = "台灣銀行"
            bankModel.bankBranch = "總行"
            bankModel.sellingTHB = BT
            bankModel.sellingUSD = BU
            bankModel.coordinate.append(coordinate)

            try! realm.write {
                realm.add(bankModel, update: true)
                group.leave()
            }


        }
    }

    func parseBangkokBankHTML(html: String) {

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {


            var BU: String = ""

            var BT: String = ""


            for rate in doc.xpath("//div[@id='container']/center/table/tr[6]/td[3]") {

                BT = rate.text!

                print ("盤谷銀行 泰銖賣匯", rate.text!)

            }

            for rate in doc.xpath("//div[@id='container']/center/table/tr[4]/td[3]") {

                BU = rate.text!

                print ("盤谷銀行 美金賣匯", rate.text!)

            }


            let realm = try! Realm()
            let bankModel = BankModel()
            let coordinate = LocationModel()

            coordinate.locationId = "1"
            coordinate.longitude = "25.0528369"
            coordinate.latitude = "121.5311522"

            bankModel.bankModelId = "2"
            bankModel.bankName = "盤谷銀行"
            bankModel.sellingTHB = BT
            bankModel.sellingUSD = BU
            bankModel.coordinate.append(coordinate)

            try! realm.write {
                realm.add(bankModel, update: true)

                group.leave()

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
                coordinate.longitude = "13.7379903"
                coordinate.latitude = "100.5543671"

                let coordinate2 = LocationModel()

                coordinate2.locationId = "2"
                coordinate2.longitude = "13.7230359"
                coordinate2.latitude = "100.5179662"

                let coordinate3 = LocationModel()

                coordinate3.locationId = "3"
                coordinate3.longitude = "13.7455814"
                coordinate3.latitude = "100.5318784"


                bankModel.bankModelId = "4"
                bankModel.bankName = "SuperRich Orange"
                bankModel.bankBranch = "Branch"
                bankModel.buyingUSD = "\(buyingUSDRepalced)"
                bankModel.buyingTWD = "\(buyingTWDRepalced)"
                bankModel.coordinate.append(coordinate)

                try! realm.write {
                    realm.add(bankModel, update: true)
                    group.leave()
                }

            } else {
                group.leave()
            }

        } else {

            print ("BRUH")

        }
    }

    func parseSPOrangeBr6(html: String) {

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {


            let path = doc.xpath("//div[@class=\"row_rate\"]/div[@class=\"row\"]/div[@class =\"col-xs-3 text-right\"]")

            //div[@class="row_rate"]/div[@class="row"]/div[@class ="col-xs-3 text-right"]

            if path.count > 0 {

                // 買匯
                let buyingTWD = path[82].text!
                var buyingTWDRepalced = buyingTWD.replacingOccurrences(of: " ", with: "")
                buyingTWDRepalced.remove(at: buyingTWDRepalced.startIndex)
                
                print ("superRich 橘標總部『台幣』『買匯』", Float(buyingTWDRepalced)!)
                
                // 美金 100 元 買匯
                let buyingUSD = path[2].text!
                var buyingUSDRepalced = buyingUSD.replacingOccurrences(of: " ", with: "")
                buyingUSDRepalced.remove(at: buyingUSDRepalced.startIndex)
                
                print ("superRich 橘標總部『美金』『買匯』", Float(buyingUSDRepalced)!)


                let realm = try! Realm()
                let bankModel = BankModel()
                let coordinate = LocationModel()

                coordinate.locationId = "1"
                coordinate.longitude = "13.748183"
                coordinate.latitude = "100.5391363"

                let coordinate2 = LocationModel()
                coordinate2.locationId = "2"
                coordinate2.longitude = "13.725814"
                coordinate2.latitude = "100.5252983"

                let coordinate3 = LocationModel()
                coordinate3.locationId = "3"
                coordinate3.longitude = "13.805863"
                coordinate3.latitude = "100.562303"


                bankModel.bankModelId = "3"
                bankModel.bankName = "SuperRich Orange"
                bankModel.bankBranch = "Head"
                bankModel.buyingUSD = "\(buyingUSDRepalced)"
                bankModel.buyingTWD = "\(buyingTWDRepalced)"
                bankModel.coordinate.append(coordinate)

                try! realm.write {
                    realm.add(bankModel, update: true)

                    group.leave()
                }


            }
            
            
        } else {
            
            print ("BRUH")
            
        }
    }

    func showNotReachableAlert() {

        SCLAlertView().showWarning("Warning", subTitle: "沒有網路的狀態下\n無法獲取最新匯率")
        
    }


    func testScrape() {

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

                self.scrapeSuperRichOrangeBr6()
                self.scrapeSuperRichOrangeBr8()

            }
        }


    }



