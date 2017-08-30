//
//  Triangle.swift
//  THBCurrencyExchanger
//
//  Created by kuanhuachen on 2017/8/30.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation
import UIKit

class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX), y: rect.minY))
        context.closePath()
        
        context.setFillColor(red: 255/255, green: 240/255, blue: 109/255, alpha: 1)
        context.fillPath()
    }
}
