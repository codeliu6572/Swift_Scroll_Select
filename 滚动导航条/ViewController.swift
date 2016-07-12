//
//  ViewController.swift
//  滚动导航条
//
//  Created by 刘浩浩 on 16/7/12.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit

let WIDTH = UIScreen.mainScreen().bounds.width
let HEIGHT = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController {

    var titleArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.automaticallyAdjustsScrollViewInsets = false
        titleArray = ["服装","美食","零食","家电折上折","装修","爱逛你就来","海淘你我他","灯饰","小商品市场","售房","电子产品","旅行特惠","门票","母婴"]
        
        let myScrollView = LHHScrollView(frame: CGRectMake(0, 64, WIDTH, HEIGHT-64), titleArray: titleArray)
        self.view.addSubview(myScrollView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

