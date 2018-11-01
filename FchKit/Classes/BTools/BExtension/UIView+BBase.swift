//
//  UIView+BExtension.swift
//  ReactiveCocoaDemo
//
//  Created by bai on 2017/10/30.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

extension UIView{
    
    func b_clipRectCorner(direction:UIRectCorner,cornerRadius:CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius);
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize);
        let maskLayer = CAShapeLayer();
        maskLayer.frame = bounds;
        maskLayer.path = maskPath.cgPath;
        layer.addSublayer(maskLayer);
        layer.mask = maskLayer;
        
        
        
    }
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    
    //抖动动画
    func b_shark() {
        // 获取到当前的View
        let viewLayer = self.layer
        
       
        
        // 获取当前View的位置
        
        let position = viewLayer.position;
        
        // 移动的两个终点位置
        
        let x = CGPoint(x: position.x + 10, y: position.y);
        let y = CGPoint(x: position.x - 10, y: position.y);
        
        
//        let x = CGPointMake(position.x + 10, position.y);
//
//        let y = CGPointMake(position.x - 10, position.y);
        
        // 设置动画
        
        let animation = CABasicAnimation.init(keyPath: "position")
        
        
//        let animation = [CABasicAnimation animationWithKeyPath:@"position"];
        
        // 设置运动形式
        
        animation.timingFunction = CAMediaTimingFunction.init(name:"default" )
//        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
        
        // 设置开始位置
        
        animation.fromValue = NSValue.init(cgPoint: x);
        
//        [animation setFromValue:[NSValue valueWithCGPoint:x]];
        
        // 设置结束位置
        animation.toValue = NSValue.init(cgPoint: y);
//        [animation setToValue:[NSValue valueWithCGPoint:y]];
        
        // 设置自动反转
        
        animation.autoreverses = true;
//        [animation setAutoreverses:YES];
        
        // 设置时间
        animation.duration = 0.06;
//        [animation setDuration:.06];
        
        // 设置次数
        animation.repeatCount = 3;
//        [animation setRepeatCount:3];
        
        // 添加上动画
        viewLayer.add(animation, forKey: nil);
//        [viewLayer addAnimation:animation forKey:nil];
    }
}
