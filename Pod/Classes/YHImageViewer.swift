//
//  YHImageViewer.swift
//  YHImageViewer
//
//  Created by yuyahirayama on 2015/07/19.
//  Copyright (c) 2015年 Yuya Hirayama. All rights reserved.
//

import UIKit

public class YHImageViewer: NSObject {

    private var window:UIWindow!
    private var backgroundView:UIView!
    private var imageView:UIImageView!
    private var startFrame:CGRect!
    
    public var backgroundColor:UIColor?
    public var fadeAnimationDuration:NSTimeInterval = 0.15
    
    public func show(targetImageView:UIImageView) {
        
        // Create UIWindow
        let window = UIWindow()
        window.frame = UIScreen.mainScreen().bounds
        window.backgroundColor = UIColor.clearColor()
        window.windowLevel = UIWindowLevelAlert
        let windowTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("windowTapped:"))
        window.addGestureRecognizer(windowTapRecognizer)
        self.window = window
        window.makeKeyAndVisible()
        
        
        // Initialize background view
        let backgroundView = UIView()
        if let color = self.backgroundColor {
            backgroundView.backgroundColor = color
        } else {
            backgroundView.backgroundColor = UIColor.blackColor()
        }
        backgroundView.frame = self.window.bounds
        backgroundView.alpha = 0
        self.window.addSubview(backgroundView)
        self.backgroundView = backgroundView
        
        
        // Initialize UIImageView
        let image = targetImageView.image
        if image == nil {
            fatalError("UIImageView is not initialized correctly.")
        }

        let imageView = UIImageView(image: image)
        self.imageView = imageView
        let startFrame = targetImageView.convertRect(targetImageView.bounds, toView: self.backgroundView)
        self.startFrame = startFrame
        imageView.frame = startFrame
        self.backgroundView.addSubview(imageView)
        
        
        // Initialize drag gesture recognizer
        let imageDragRecognizer = UIPanGestureRecognizer(target: self, action: Selector("imageDragged:"))
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(imageDragRecognizer)
        
        // Initialize pinch gesture recognizer
        let imagePinchRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("imagePinched:"))
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(imagePinchRecognizer)
        
        
        // Start animation
        UIView.animateWithDuration(self.fadeAnimationDuration, delay: 0, options: nil, animations: { () -> Void in
            backgroundView.alpha = 1
            }) { (_) -> Void in
                self.moveImageToCenter()
        }
    }
    
    func moveImageToCenter() {
        if let imageView = self.imageView {
            UIView.animateWithDuration(0.2, delay: 0, options: nil, animations: { () -> Void in
                let width = self.window.bounds.size.width
                let height = width / imageView.image!.size.width * imageView.image!.size.height
                self.imageView.frame.size = CGSizeMake(width, height)
                self.imageView.center = self.window.center
                }) { (_) -> Void in
            }
        }
    }
    
    func windowTapped(recognizer:UIGestureRecognizer) {
        self.moveToFirstFrame { () -> Void in
            self.close()
        }
    }
    
    func imageDragged(recognizer:UIPanGestureRecognizer) {
        switch (recognizer.state) {
        case .Changed:
            // Move target view
            if let targetView = recognizer.view {
                let variation = recognizer.translationInView(targetView)
                targetView.center = CGPointMake(targetView.center.x + variation.x, targetView.center.y + variation.y)
                
                let velocity = recognizer.velocityInView(targetView)
            }
            recognizer.setTranslation(CGPointZero, inView: recognizer.view)
            
        case .Ended:
            // Check velocity
            if let targetView = recognizer.view {
                let variation = recognizer.translationInView(targetView)
                let velocity = recognizer.velocityInView(targetView)
                let straightVelocity = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
                let velocityThreshold = 1000
                let goalPointRate = 5000.0
                if straightVelocity > 1000 {
                    let radian = atan2(velocity.y, velocity.x)
                    let goalPoint = CGPointMake(cos(radian) * CGFloat(goalPointRate), sin(radian) * CGFloat(goalPointRate))
                    UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: { () -> Void in
                        targetView.center = goalPoint
                    }, completion: { (_) -> Void in
                        self.close()
                    })
                } else {
                    self.moveImageToCenter()
                }
            }
        default:
            _ = 0
        }
    }
    
    func imagePinched(recognizer:UIPinchGestureRecognizer) {
        let targetView = recognizer.view!
        let scale = recognizer.scale
        let velocity = recognizer.velocity
        let point = recognizer.locationInView(targetView)
        switch (recognizer.state) {
        case .Changed:
            let transform = targetView.transform.a
            targetView.transform = CGAffineTransformMakeScale(scale, scale)
        case .Ended , .Cancelled :
            if scale < 1.0 {
                self.moveImageToCenter()
            } else {
            }
        default:
            _ = 0
        }
    }
    
    func close() {
        UIView.animateWithDuration(self.fadeAnimationDuration, delay: 0, options: nil, animations: { () -> Void in
            self.backgroundView.alpha = 0
            }) { (_) -> Void in
                self.window = nil
        }
    }

    func moveToFirstFrame(completion: () -> Void) {
        UIView.animateWithDuration(0.2, delay: 0, options: nil, animations: { () -> Void in
            self.imageView.frame = self.startFrame
            }) { (_) -> Void in
                completion()
        }
    }
}
