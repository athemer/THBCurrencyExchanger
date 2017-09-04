//
//  ResultViewController.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/23.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import Hero

class ResultViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var close_Button: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!

    let calculator = Calculator()


    var resultModelArray: [ResultModel] = []


    var totalTWD: Double = 0.0
    var TWB_sellingTHB: Double = 0.0
    var TWB_sellingUSD: Double = 0.0
    var BKB_sellingTHB: Double = 0.0
    var SPO_Head_BuyingTWD: Double = 0.0
    var SPO_Head_BuyingUSD: Double = 0.0
    var SPO_Branch_BuyingTWD: Double = 0.0
    var SPO_Branch_BuyingUSD: Double = 0.0
    var SPG_Head_BuyingTWD: Double = 0.0
    var SPG_Head_BuyingUSD: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        collectionView.delegate = self
        collectionView.dataSource = self

        tableView.rowHeight = 170
        tableView.separatorStyle = .none

        registerCell()
        setupLayout()


        close_Button.layer.cornerRadius = 20
        
        self.tableView.allowsSelection = false


        setUpResultModel()



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerCell() {

        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)

        self.tableView.register(nib, forCellReuseIdentifier: "resultCell")

        let nib2 = UINib(nibName: "BanksCollectionViewCell", bundle: nil)
        
        self.collectionView.register(nib2, forCellWithReuseIdentifier: "BankCell")
        
    }

    func setupLayout() {

        let layout = UPCarouselFlowLayout()
        let height = self.collectionView.bounds.height
        layout.itemSize = CGSize(width: 300, height: 200)
        
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }

    func setUpResultModel() {
        
        print ("@@@@ TWB_sellingTHB", self.TWB_sellingTHB)
        print ("@@@@ TWB_sellingUSD", self.TWB_sellingUSD)
        print ("@@@@ BKB_sellingTHB", self.BKB_sellingTHB)
        print ("@@@@ SPO_Head_BuyingTWD", self.SPO_Head_BuyingTWD)
        print ("@@@@ SPO_Head_BuyingUSD", self.SPO_Head_BuyingUSD)
        print ("@@@@ SPO_Branch_BuyingTWD", self.SPO_Branch_BuyingTWD)
        print ("@@@@ SPO_Branch_BuyingUSD", self.SPO_Branch_BuyingUSD)
        print ("@@@@ SPG_Head_BuyingTWD", self.SPG_Head_BuyingTWD)
        print ("@@@@ SPG_Head_BuyingUSD", self.SPG_Head_BuyingUSD)

        self.resultModelArray = calculator.setUpModelArray(totalTWD: 10000.0,
                        TWB_sellingTHB: self.TWB_sellingTHB,
                        TWB_sellingUSD: self.TWB_sellingUSD,
                        BKB_sellingTHB: self.BKB_sellingTHB,
                        SPO_Head_BuyingTWD: self.SPO_Head_BuyingTWD,
                        SPO_Head_BuyingUSD: self.SPO_Head_BuyingUSD,
                        SPO_Branch_BuyingTWD: self.SPO_Branch_BuyingTWD,
                        SPO_Branch_BuyingUSD: self.SPO_Branch_BuyingUSD,
                        SPG_Head_BuyingTWD: self.SPG_Head_BuyingTWD,
                        SPG_Head_BuyingUSD: self.SPG_Head_BuyingUSD)

        self.tableView.reloadData()
        

        for model in resultModelArray {


            print (" @@@@@ ", model.resultTHB)
            
            
        }

    }


    @IBAction func closeButtonPressed(_ sender: UIButton) {

        dismiss(animated: true, completion: nil)
    }

}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultModelArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultTableViewCell

        cell.resultTHB_Label.text = String(self.resultModelArray[indexPath.row].resultTHB)

        return cell

    }



}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource{

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

    
}
