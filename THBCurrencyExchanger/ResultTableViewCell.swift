//
//  ResultTableViewCell.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/30.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {


    
    @IBOutlet weak var baseResultView: UIView!

    @IBOutlet weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        shadowView.layer.shouldRasterize = true
        
        
        baseResultView.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
