//
//  CacheVC.swift
//  滚动导航条
//
//  Created by 刘浩浩 on 16/7/12.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit

class CacheVC: NSObject {

    var vcArray = NSMutableArray()
    /**
     添加未创建的控制器的标签号
     
     - parameter currentIndex: 当前创建控制器是第几个
     */
    func addCurrentVC(currentIndex:Int) {
        vcArray.addObject(currentIndex)
    }
    /**
     是否添加过这个控制器
     
     - parameter currentIndex: 通过标签号判断是不是添加过
     
     - returns: 创建了return ture，反之相反
     */
    func hasCurrentVC(currentIndex:Int) -> Bool{
        if vcArray.containsObject(currentIndex) {
            return true
        }
        else
        {
            return false
        }
    }
    
    
}
