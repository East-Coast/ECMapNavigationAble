//
//  ViewController.swift
//  ECMapNavigationAble
//
//  Created by East-Coast on 07/06/2017.
//  Copyright (c) 2017 East-Coast. All rights reserved.
//

import UIKit
import CoreLocation
import ECMapNavigationAble

class ViewController: UIViewController,ECMapNavigationAble {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
      let label = UILabel(frame: view.bounds)
      label.text = "点击屏幕"
      label.textAlignment = .center
      view.addSubview(label)
      
    
      
    }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    let destination = CLLocationCoordinate2D(latitude: 30.2853100000, longitude: 120.1001900000)
    showNavigationListAlert(destination: destination, locationType: .gcj02, scheme: "ecmapnavigation")
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

