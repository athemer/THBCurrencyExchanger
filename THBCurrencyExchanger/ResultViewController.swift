//
//  ResultViewController.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/23.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class ResultViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var close_Button: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!

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


    @IBAction func closeButtonPressed(_ sender: UIButton) {

        dismiss(animated: true, completion: nil)

    }

}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultTableViewCell

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
