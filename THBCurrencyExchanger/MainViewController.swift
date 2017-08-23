//
//  MainViewController.swift
//  THBCurrencyExchanger
//
//  Created by kuanhuachen on 2017/8/22.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
        
        self.tabBarController?.tabBar.barTintColor = .black

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



