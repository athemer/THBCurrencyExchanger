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


//    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var close_Button: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!

    let calculator = Calculator()


    let imageViewHeight: CGFloat = 150.0

    let imageView = UIImageView()

    let tableView = UITableView()

    var imageViewTopConstraint: NSLayoutConstraint?

    var imageViewHeightConstraint: NSLayoutConstraint?

    var tableViewTopConstraint: NSLayoutConstraint?

    var resultModelArray: [ResultModel] = []

    var TWD: Double = 0.0
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

        collectionView.delegate = self
        collectionView.dataSource = self

        tableView.rowHeight = 250
        tableView.separatorStyle = .none

        registerCell()
        setupLayout()


        close_Button.layer.cornerRadius = 20
        
        self.tableView.allowsSelection = false


        setUpResultModel()


        automaticallyAdjustsScrollViewInsets = false

        setUpTableView()

        setUpImageView()



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

        self.resultModelArray = calculator.setUpModelArray(totalTWD: self.TWD,
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

    func setUpTableView() {
        //2
        tableView.contentInset = UIEdgeInsets(top: imageViewHeight, left: 0, bottom: 0, right: 0)
        //3
        tableView.contentOffset = CGPoint(x: 0, y: -imageViewHeight)

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: view.topAnchor)

        tableViewTopConstraint?.isActive = true

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true

        self.view.bringSubview(toFront: close_Button)

    }

    func setUpImageView() {

        imageView.image = UIImage(named: "TRO")

        imageView.contentMode = .scaleAspectFit

        imageView.clipsToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.backgroundColor = UIColor(red: 73/255, green: 57/255, blue: 151/255, alpha: 1)

        view.addSubview(imageView)

        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: view.topAnchor)

        imageViewTopConstraint?.isActive = true

        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageViewHeight)
        
        imageViewHeightConstraint?.isActive = true
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (scrollView.contentOffset.y > -imageViewHeight) && (scrollView.contentOffset.y < 20) {

            changeImageViewTopConstraint(contentOffset: scrollView.contentOffset)
            changeTableViewHeightConstraint(contentOffset: scrollView.contentOffset)

        } else if scrollView.contentOffset.y <= -imageViewHeight {

            changeImageViewHeightConstraint(contentOffset: scrollView.contentOffset)
        }
    }

    func changeImageViewTopConstraint(contentOffset: CGPoint) {

        imageViewTopConstraint?.isActive = false

        imageViewHeightConstraint?.isActive = false

        imageViewTopConstraint = imageView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: -(contentOffset.y - (-imageViewHeight))
        )

        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageViewHeight)

        imageViewTopConstraint?.isActive = true

        imageViewHeightConstraint?.isActive = true

        view.layoutIfNeeded()
    }

    func changeImageViewHeightConstraint(contentOffset: CGPoint) {

        imageViewTopConstraint?.isActive = false

        imageViewHeightConstraint?.isActive = false

        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: view.topAnchor)

        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: -contentOffset.y)

        imageViewTopConstraint?.isActive = true

        imageViewHeightConstraint?.isActive = true

        view.layoutIfNeeded()
    }

    func changeTableViewHeightConstraint(contentOffset: CGPoint) {

        tableViewTopConstraint?.isActive = false


//        var const = 0
//
//        if -(contentOffset.y - (-imageViewHeight)) > 0 {
//
//            const = -(contentOffset.y - (-imageViewHeight))
//
//        } else {
//
//
//        }


        tableViewTopConstraint = tableView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: -(contentOffset.y - (-imageViewHeight))
        )

        tableViewTopConstraint?.isActive = true
        
        view.layoutIfNeeded()
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


        let arr = self.resultModelArray[indexPath.row]

        cell.resultTHB_Label.text = String(self.resultModelArray[indexPath.row].resultTHB.rounded())

        cell.label_1.text = arr.bankNameSecond != nil ? "先在『\(arr.countryFirst!)』的『\(arr.bankNameFirst!)』" : "直接在『\(arr.countryFirst!)』的『\(arr.bankNameFirst!)』"

        cell.label_2.text = arr.bankNameSecond != nil ? "用『台幣』換『\(arr.currencyNameFirst!)』" : "用『台幣』換『泰銖』"

        cell.label_3.text = arr.bankNameSecond != nil ? "然後在『\(arr.countrySecond!)』的『\(arr.bankNameSecond!)』" : ""

        cell.label_4.text = arr.bankNameSecond != nil ? "用『美金』換『泰銖』" : ""



        return cell

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "*******"
//    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            let view = UIView()

            view.height = 50
            view.width = 375

            view.backgroundColor = UIColor(red: 73/255, green: 57/255, blue: 151/255, alpha: 1)

            let label = UILabel()

            label.text = "換匯結果列表"

//            label.translatesAutoresizingMaskIntoConstraints = false
//
//            label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//
//            label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//            label.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true


            label.frame = view.bounds

            label.textAlignment = .center
            label.textColor = .white
            
            view.addSubview(label)
            
            return view


//        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewTableViewCell") as! HeaderViewTableViewCell
//
//        return cell
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
