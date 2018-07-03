//
//  StringExtension.swift
//  TestTaskRegistrationForm
//
//  Created by JigSaw on 03.07.2018.
//  Copyright © 2018 poulkravtsoff. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func isValidEmail() -> Bool {
                let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
                return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    func whatEmailDidInvalid() -> String {
        var message = String()
        var firstPartOfEmail = String()
        var theSecondPartOfEmail = String()
        
        if (self.range(of: "@") != nil){
            let splitedStringArray: [String] = self.components(separatedBy: "@")
            if splitedStringArray.count > 2 {
                message = "You enter more than one '@' symbol"
            }else{
                firstPartOfEmail = splitedStringArray[0]
                theSecondPartOfEmail = splitedStringArray[1]
                print("first \(firstPartOfEmail)")
                print("second \(theSecondPartOfEmail)")
                //checking dot symbol
                if theSecondPartOfEmail != "" {
                    if (theSecondPartOfEmail.range(of: ".") != nil) {
                        if verifyUrl(theSecondPartOfEmail) {
                            message = "You domain name is correct"
                        }else{
                            message = "Your domain name is invalid"
                        }
                    }else{
                        message = "You forget write '.' in domain name"
                    }
                }else{
                    message = "You Forget write the domain"
                }
            }
        }else{
            message = "email does not contain `@`"
        }
        return message
    }
    
    func verifyUrl(_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
}
