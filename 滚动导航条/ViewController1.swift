//
//  ViewController1.swift
//  滚动导航条
//
//  Created by 刘浩浩 on 16/7/12.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    var contentID = NSString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        
        let R = random()%256
        let G = random()%256
        let B = random()%256
        self.view.backgroundColor = UIColor(red: CGFloat(R)/256, green: CGFloat(G)/256, blue: CGFloat(B)/256, alpha: 1)
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
