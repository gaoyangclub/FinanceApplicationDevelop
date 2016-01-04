//
//  ViewController.swift
//  VideoPlayerApplication
//
//  Created by 高扬 on 16/1/3.
//  Copyright (c) 2016年 高扬. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        VideoPlayerKit.initialize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

