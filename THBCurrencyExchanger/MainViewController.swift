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

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let networkManager = NetworkManager()
    
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
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 235/255, green: 123/255, blue: 45/255, alpha: 1)
        
        print (" @@@@@ check reachability ", networkManager.isReachable())

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showNotReachableAlert()

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

    @IBAction func toMap(_ sender: Any) {

        performSegue(withIdentifier: "mainToMap", sender: nil)

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



