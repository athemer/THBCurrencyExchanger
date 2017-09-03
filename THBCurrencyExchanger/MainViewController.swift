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
import Spring


class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var top: GradientView!

    @IBOutlet weak var baseTextView: UIView!

    @IBOutlet weak var goButton: UIButton!

    let manager = NetWorkManager()

    var bo: Bool = false
    

    //Rates
    var TWB_sellingTHB: Double = 0.0
    var TWB_sellingUSD: Double = 0.0
    var BKB_sellingTHB: Double = 0.0
    var SPO_Head_BuyingTWD: Double = 0.0
    var SPO_Head_BuyingUSD: Double = 0.0
    var SPO_Branch_BuyingTWD: Double = 0.0
    var SPO_Branch_BuyingUSD: Double = 0.0
    var SPG_Head_BuyingTWD: Double = 0.0
    var SPG_Head_BuyingUSD: Double = 0.0


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


        // dismiss keyboard 
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))


//        baseTextView.layer.shadowColor = UIColor.black.cgColor
//        baseTextView.layer.shadowOpacity = 1
//        baseTextView.layer.shadowOffset = CGSize.zero
//        baseTextView.layer.shadowRadius = 10
//        baseTextView.layer.shadowPath = UIBezierPath(rect: baseTextView.bounds).cgPath
//        baseTextView.layer.shouldRasterize = true



        let cgColor1 = UIColor(red: 255/255, green: 240/255, blue: 109/255, alpha: 1).cgColor
        let cgColor2 = UIColor(red: 255/255, green: 240/255, blue: 169/255, alpha: 1).cgColor
    
        top.gradientLayer.colors = [cgColor1, cgColor2]
        top.gradientLayer.gradient = GradientPoint.topBottom.draw()
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        self.manager.scapeChain()

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

        let frame = self.baseTextView.bounds

        let textField = SkyFloatingLabelTextField(frame:frame)
        textField.placeholder = "請輸入台幣總金額"
        textField.title = "台幣金額"
        textField.font = UIFont(name: "Avenir Next", size: 50)
        textField.placeholderFont = UIFont(name: "Avenir Next", size: 25)
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.textAlignment = .center
//        textField.borderWidth = 1
//        textField.borderColor = .black
        self.baseTextView.addSubview(textField)


    }

    func readResults(){

        let realm = try! Realm()
        let models = realm.objects(BankModel.self)
        if models.count > 0 {

//            let corrdinate = models[0].coordinate[0].latitude

            for model in models {


                if model.bankModelId == "1" {

                    self.TWB_sellingTHB = Double(model.sellingTHB!)!
                    self.TWB_sellingUSD = Double(model.sellingUSD!)!

                } else if model.bankModelId == "2" {

                    self.BKB_sellingTHB = Double(model.sellingTHB!)!

                } else if model.bankModelId == "3" {

                    self.SPO_Head_BuyingTWD = Double(model.buyingTWD!)!
                    self.SPO_Head_BuyingUSD = Double(model.buyingUSD!)!
                    
                } else if model.bankModelId == "4" {

                    self.SPO_Branch_BuyingTWD = Double(model.buyingTWD!)!
                    self.SPO_Branch_BuyingUSD = Double(model.buyingUSD!)!
                    
                } else if model.bankModelId == "5" {

                    self.SPG_Head_BuyingTWD = Double(model.buyingTWD!)!
                    self.SPG_Head_BuyingUSD = Double(model.buyingUSD!)!

                }

                print (" @@@@@ ", model.bankName )

            }

        }
    }

    @IBAction func toMap(_ sender: Any) {


//        if self.bo {
//
            readResults()
//            self.bo = false
//
//
//        } else {
//
//            self.manager.scapeChain()
//            self.bo = true
//
//
//        }

//        performSegue(withIdentifier: "mainToMap", sender: nil)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController")
//        self.present(vc!, animated: true, completion: nil)

    }


    @IBAction func goButtonPressed(_ sender: UIButton) {

//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else { return }

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController

        vc.TWB_sellingUSD = self.TWB_sellingUSD
        vc.TWB_sellingTHB = self.TWB_sellingTHB
        vc.BKB_sellingTHB = self.BKB_sellingTHB
        vc.SPO_Head_BuyingUSD = self.SPO_Head_BuyingUSD
        vc.SPO_Head_BuyingTWD = self.SPO_Head_BuyingTWD
        vc.SPO_Branch_BuyingUSD = self.SPO_Branch_BuyingUSD
        vc.SPO_Branch_BuyingTWD = self.SPO_Branch_BuyingTWD
        vc.SPG_Head_BuyingTWD = self.SPG_Head_BuyingTWD
        vc.SPG_Head_BuyingUSD = self.SPG_Head_BuyingUSD

        self.present(vc, animated: true, completion: nil)

//        performSegue(withIdentifier: "toResult", sender: nil)


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



