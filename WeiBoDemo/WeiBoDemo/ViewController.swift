//
//  ViewController.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/28/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "asdasdasdasd"
        Alamofire.request(urlStr).responseJSON { (response) in
            
        }
        
    }


}

