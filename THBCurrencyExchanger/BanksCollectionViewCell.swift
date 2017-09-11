//
//  BanksCollectionViewCell.swift
//  THBCurrencyExchanger
//
//  Created by kuanhuachen on 2017/8/22.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit

class BanksCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var baseView: UIView!

    @IBOutlet weak var map_Button: UIButton!

    @IBOutlet weak var bankName_Label: UILabel!

    @IBOutlet weak var bankBranch_Label: UILabel!

    @IBOutlet weak var rate_1_name_Label: UILabel!

    @IBOutlet weak var rate_2_name_Label: UILabel!

    @IBOutlet weak var rate_1_Label: UILabel!
    
    @IBOutlet weak var rate_2_Label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        baseView.layer.cornerRadius = 25

        let rectShape = CAShapeLayer()
        rectShape.bounds = self.map_Button.frame
        rectShape.position = self.map_Button.center
        rectShape.path = UIBezierPath(roundedRect: self.map_Button.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 25, height: 25)).cgPath

        self.map_Button.layer.backgroundColor = UIColor(red: 68/255, green: 175/255, blue: 225/255, alpha: 1).cgColor
        self.map_Button.layer.mask = rectShape
        
        
    }

}
