//
//  RondedView.swift
//  TestTaskRegistrationForm
//
//  Created by JigSaw on 02.07.2018.
//  Copyright © 2018 poulkravtsoff. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
}
