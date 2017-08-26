//
//  MainViewController.swift
//  THBCurrencyExchanger
//
//  Created by kuanhuachen on 2017/8/22.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import SCLAlertView
import SkyFloatingLabelTextField
import RealmSwift
import EZLoadingActivity

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var buttomBaseView: UIView!

    let manager = NetWorkManager()

    var bo: Bool = false

    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerCell()
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 200)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 73/255, green: 57/255, blue: 151/255, alpha: 1)

        configureTextField()





    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        self.manager.scrapeSuperRichOrangeBr8()
//        self.showNotReachableAlert()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        
        print (" @@@@@ MainViewController has been deinited ")
        
    }
    
    func registerCell() {
        
        let nib = UINib(nibName: "BanksCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "BankCell")
        
    }

    func showNotReachableAlert() {

        SCLAlertView().showWarning("Warning", subTitle: "沒有網路的狀態下\n無法獲取最新匯率")

    }

    func configureTextField() {

        let textField = SkyFloatingLabelTextField(frame: CGRect(x: 50, y: 125, width: 300, height: 100))
        textField.placeholder = "Name"
        textField.title = "Your full name"
        textField.font = UIFont(name: "Avenir Next", size: 50)
        textField.placeholderFont = UIFont(name: "Avenir Next", size: 25)
        textField.keyboardType = .numberPad
        textField.delegate = self
        self.buttomBaseView.addSubview(textField)


    }


    func readResults(){
        let realm = try! Realm()
        let users = realm.objects(BankModel.self)
        if users.count > 0 {
            print(users[0].bankName)
        }
    }

    @IBAction func toMap(_ sender: Any) {


        if self.bo {

            readResults()


        } else {

            self.manager.scrapeSuperRichOrangeBr8()
            self.bo = true


        }




        //performSegue(withIdentifier: "mainToMap", sender: nil)

    }


}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "BankCell", for: indexPath) as! BanksCollectionViewCell
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (" @@@@@ ", indexPath.item)
    }
    
}

extension MainViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // Uses the number format corresponding to your Locale
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0


        // Uses the grouping separator corresponding to your Locale
        // e.g. "," in the US, a space in France, and so on
        if let groupingSeparator = formatter.groupingSeparator {

            if string == groupingSeparator {
                return true
            }


            if let textWithoutGroupingSeparator = textField.text?.replacingOccurrences(of: groupingSeparator, with: "") {
                var totalTextWithoutGroupingSeparators = textWithoutGroupingSeparator + string
                if string == "" { // pressed Backspace key
                    totalTextWithoutGroupingSeparators.characters.removeLast()
                }
                if let numberWithoutGroupingSeparator = formatter.number(from: totalTextWithoutGroupingSeparators),
                    let formattedText = formatter.string(from: numberWithoutGroupingSeparator) {
                    
                    textField.text = formattedText
                    return false
                }
            }
        }


        return true
    }

}



