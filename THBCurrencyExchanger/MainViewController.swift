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

        
//        self.manager.scrapeSuperRichOrangeBr8()
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
        let users = realm.objects(BankModel.self)
        if users.count > 0 {
            print(users[0].bankName)
        }
    }

    @IBAction func toMap(_ sender: Any) {


//        if self.bo {
//
//            readResults()
//
//
//        } else {
//
//            self.manager.scrapeSuperRichOrangeBr8()
//            self.bo = true
//
//
//        }

//        performSegue(withIdentifier: "mainToMap", sender: nil)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController")
        self.present(vc!, animated: true, completion: nil)

    }


    @IBAction func goButtonPressed(_ sender: UIButton) {

//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else { return }

        performSegue(withIdentifier: "toResult", sender: nil)


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



