//
//  RoundedTextField.swift
//  TestTaskRegistrationForm
//
//  Created by JigSaw on 03.07.2018.
//  Copyright © 2018 poulkravtsoff. All rights reserved.
//


import UIKit

class RoundedTextField: UITextField {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        autocorrectionType = .no
        adjustsFontSizeToFitWidth = true
        clearButtonMode = .whileEditing
        textAlignment = .center
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        
    }


}
