//
//  HappinessViewController.swift
//  Happiness
//
//  Created by 牛野 on 15/8/2.
//  Copyright © 2015年 Noah. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController {
    var happiness: Int = 75 { // 0 = very sad , 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0 ),100)
            print("happiness = \(happiness)")
            updateUI()

        }
    }
    func updateUI(){
        
    }
    func smilinessForFaceView(sender: FaceView) -> Double?{
        return Double(happiness - 50) / 50
    }

}
