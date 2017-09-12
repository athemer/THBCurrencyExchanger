//
//  ExtensionsUIView.swift
//  THBCurrencyExchanger
//
//  Created by kuanhuachen on 2017/9/12.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // Call: xxxView.loadFromNibNamed("nib name")
    public class func loadFromNibName(nibNamed: String, owner: AnyObject?, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    public func removeAllSubViews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    /// if afterScreenUpdates is true, screens hot with flash.
    public func screenShot(afterScreenUpdates: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, UIScreen.main.scale)
        self.drawHierarchy(in: self.frame, afterScreenUpdates: afterScreenUpdates)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public func copyView() -> UIView? {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as? UIView
    }
}
