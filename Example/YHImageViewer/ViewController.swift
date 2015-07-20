//
//  ViewController.swift
//  YHImageViewerSample
//
//  Created by yuyahirayama on 2015/07/19.
//  Copyright (c) 2015年 Yuya Hirayama. All rights reserved.
//

import UIKit
import YHImageViewer

class ViewController: UIViewController {
    
    var imageViewer:YHImageViewer?

    @IBOutlet weak var sampleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        self.sampleImageView.userInteractionEnabled = true
        self.sampleImageView.addGestureRecognizer(imageTapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(recognizer:UITapGestureRecognizer) {
        let imageViewer = YHImageViewer()
        imageViewer.backgroundColor = UIColor.blackColor()
        self.imageViewer = imageViewer
        imageViewer.show(sampleImageView)
    }

}

