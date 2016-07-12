//
//  LHHScrollView.swift
//  滚动导航条
//
//  Created by 刘浩浩 on 16/7/12.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit




class LHHScrollView: UIView,UIScrollViewDelegate {

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var mainScrollView = UIScrollView()
    var titleScrollView = UIScrollView()
    
    var underLine = UIView()
    var _titleArray = NSArray()
    var selectIndex:Int = 0
    var cacheVC = CacheVC()
    
    
    
    /**
     初始化方法
     
     - parameter frame:      定义大小范围
     - parameter titleArray: 盛放标题
     
     - returns: nil
     */
    init(frame:CGRect , titleArray:NSArray) {
        super.init(frame: frame)
        _titleArray = NSArray(array: titleArray)
        self.backgroundColor = UIColor.lightGrayColor()
        self.creatMainScrollView(UIColor.whiteColor())
        self.creatSelectBtn(_titleArray)
        self.creatTitleScrollView()
    }
    /**
     创建滚动界面
     
     - parameter bgColor: 设置滚动条背景颜色
     */
    func creatMainScrollView(bgColor:UIColor) {
        
        mainScrollView.bounces = false
        mainScrollView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64)
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.userInteractionEnabled = true
        mainScrollView.delegate = self
        mainScrollView.contentSize = CGSizeMake(CGFloat(_titleArray.count) * WIDTH, HEIGHT - 64)
        mainScrollView.scrollEnabled = true
        mainScrollView.pagingEnabled = true
        mainScrollView.backgroundColor = bgColor
        self.addSubview(mainScrollView)

    }
    /**
     创建滚动条
     */
    func creatTitleScrollView() {
        titleScrollView.bounces = false
        titleScrollView.frame = CGRectMake(0, 0, WIDTH, 42)
        titleScrollView.showsHorizontalScrollIndicator = false
        titleScrollView.showsVerticalScrollIndicator = false
        titleScrollView.userInteractionEnabled = true
        titleScrollView.scrollEnabled = true
        titleScrollView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(titleScrollView)

    }
    /**
     创建按钮和滑块
     
     - parameter titleArray: 标题
     */
    func creatSelectBtn(titleArray:NSArray) {
        var width:CGFloat
        width = 5
        for index in 0..<titleArray.count {
            
            let btn = UIButton(type: .Custom)
            btn.frame = CGRectMake(width, 5, self.legthOfTitle(titleArray[index] as! String)+30, 30)
            btn.setTitle(titleArray[index] as? String, forState: .Normal)
            btn.backgroundColor = UIColor.orangeColor()
            btn.layer.cornerRadius = 5
            btn.titleLabel?.font = UIFont.systemFontOfSize(13)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.tag = index + 50
            btn.addTarget(self, action: #selector(self.btnAction(_:)), forControlEvents: .TouchUpInside)
            titleScrollView.addSubview(btn)
            
            let lineView = UIView(frame: CGRectMake(width, 39, self.legthOfTitle(titleArray[index] as! String)+30, 3))
            lineView.tag = 100 + index
            lineView.backgroundColor = UIColor.redColor()
            lineView.hidden = true
            titleScrollView.addSubview(lineView)
            
            if index == 50 {
                btn.setTitleColor(UIColor.redColor(), forState: .Selected)
            }
            if lineView.tag == 100 {
                lineView.hidden = false
            }
            
            width = width + self.legthOfTitle(titleArray[index] as! String) + 30 + 10
        }
        selectIndex = 0
        titleScrollView.contentSize = CGSizeMake(width, 40)
        let viewVC = ViewController1()
        viewVC.contentID =  "\(selectIndex)"
        viewVC.view.frame = CGRectMake(0, 42, WIDTH, HEIGHT - 64 - 42)
        mainScrollView.addSubview(viewVC.view)
        cacheVC.addCurrentVC(selectIndex)

    }
    /**
     计算标题长度
     
     - parameter title: 标题
     
     - returns: 标题长度
     */
    func legthOfTitle(title:String) -> CGFloat {
        let attribute = [NSFontAttributeName: UIFont.systemFontOfSize(13)]
//        let text: NSString = NSString(CString: title.cStringUsingEncoding(NSUTF8StringEncoding)!,encoding: NSUTF8StringEncoding)!
        let option = NSStringDrawingOptions.UsesFontLeading
        let size = title.boundingRectWithSize(CGSizeMake(1000, 30), options:option, attributes: attribute, context: nil)
        return size.width
    }
    /**
     点击按钮响应事件
     
     - parameter btn: tag从50开始
     */
    func btnAction(btn:UIButton) {
        selectIndex = btn.tag - 50
        print(btn.tag)
        /// 按钮和滑块变为未选状态
        for var view in titleScrollView.subviews {
            if view.isKindOfClass(UIButton) {
                let button = view as! UIButton
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
            else
            {
                let lineView = view 
                lineView.hidden = true
            }
            
        }
        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        let lineView = titleScrollView.viewWithTag(selectIndex + 100)
        lineView?.hidden = false
        /**
         *  对当前控制器做处理
         *
         *  @param selectIndex 当前控制器标号
         *
         *  @return nil
         */
        if !cacheVC.vcArray.containsObject(selectIndex) {
            let viewVC = ViewController1()
            viewVC.contentID =  "\(selectIndex)"
            viewVC.view.frame = CGRectMake(CGFloat(selectIndex) * WIDTH, 42, WIDTH, HEIGHT - 64 - 42)
            mainScrollView.addSubview(viewVC.view)
            cacheVC.addCurrentVC(selectIndex)
        }
        /**
         *  设置偏移量
         *
         *  @param self.selectIndex 当前位置
         *
         *  @return nil
         */
        self.mainScrollView.contentOffset = CGPointMake(CGFloat(self.selectIndex) * WIDTH, 0)
        /// 获取当前按钮左右按钮
        let btnRight = titleScrollView.viewWithTag(btn.tag + 1)
        let btnLeft = titleScrollView.viewWithTag(btn.tag - 1)
        /**
         *  通过位置判断偏移量
         */
        if (btn.frame.origin.x + btn.frame.size.width) > WIDTH - 10{
            if btn.tag - 50 != _titleArray.count - 1 {
                UIView.animateWithDuration(0.3, animations: {
                    self.titleScrollView.contentOffset = CGPointMake(btnRight!.frame.origin.x + btnRight!.frame.size.width - WIDTH + 10, 0);
                })
            }
            
            
        }
        else
        {
            if selectIndex == 0 {
                UIView.animateWithDuration(0.3, animations: {
                    self.titleScrollView.contentOffset = CGPointMake(0, 0)
                })
            }
            else
            {
                UIView.animateWithDuration(0.3, animations: {
                    self.titleScrollView.contentOffset = CGPointMake(btnLeft!.frame.origin.x, 0)
                })
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     scrollView代理方法
     
     - parameter scrollView: 滑动界面相应事件
     */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        selectIndex = Int(mainScrollView.contentOffset.x / WIDTH)
        /// 按钮和滑块变为未选状态
        for var view in titleScrollView.subviews {
            if view.isKindOfClass(UIButton) {
                let button = view as! UIButton
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
            else
            {
                let lineView = view
                lineView.hidden = true
            }
            
        }
        let btn = titleScrollView.viewWithTag(selectIndex + 50) as! UIButton

        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        let lineView = titleScrollView.viewWithTag(selectIndex + 100)
        lineView?.hidden = false
        /**
         *  对当前控制器做处理
         *
         *  @param selectIndex 当前控制器标号
         *
         *  @return nil
         */
        if !cacheVC.vcArray.containsObject(selectIndex) {
            let viewVC = ViewController1()
            viewVC.contentID =  "\(selectIndex)"
            viewVC.view.frame = CGRectMake(CGFloat(selectIndex) * WIDTH, 42, WIDTH, HEIGHT - 64 - 42)
            mainScrollView.addSubview(viewVC.view)
            cacheVC.addCurrentVC(selectIndex)
        }
        /**
         *  设置偏移量
         *
         *  @param self.selectIndex 当前位置
         *
         *  @return nil
         */

        self.mainScrollView.contentOffset = CGPointMake(CGFloat(selectIndex) * WIDTH, 0)
        /// 获取当前按钮左右按钮
        let btnRight = titleScrollView.viewWithTag(selectIndex + 50 + 1)
        let btnLeft = titleScrollView.viewWithTag(selectIndex + 50 - 1)
        
        /**
         *  通过位置判断偏移量
         */
        if (btn.frame.origin.x + btn.frame.size.width) > WIDTH - 10{
            if btn.tag - 50  != _titleArray.count - 1 {
                UIView.animateWithDuration(0.3, animations: {
                    self.titleScrollView.contentOffset = CGPointMake(btnRight!.frame.origin.x + btnRight!.frame.size.width - WIDTH + 10, 0);
                })
            }
            
            
        }
        else
        {
            if selectIndex == 0 {
                UIView.animateWithDuration(0.3, animations: {
                    self.titleScrollView.contentOffset = CGPointMake(0, 0)
                })
            }
            else
            {
                UIView.animateWithDuration(0.3, animations: {
                    self.titleScrollView.contentOffset = CGPointMake(btnLeft!.frame.origin.x, 0)
                })
            }
        }

    }
    

    
    

}
