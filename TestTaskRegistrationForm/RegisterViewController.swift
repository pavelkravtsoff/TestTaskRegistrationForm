//
//  RegisterViewController.swift
//  TestTaskRegistrationForm
//
//  Created by JigSaw on 02.07.2018.
//  Copyright © 2018 poulkravtsoff. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var imageView = UIImageView()
    var firstNameImageView = UIImageView()
    var lastNameImageView = UIImageView()
    var countryImageView = UIImageView()
    var ageImageView = UIImageView()
    var emailImageView = UIImageView()
    var passwordImageView = UIImageView()
    var reEnterPasswordImageView = UIImageView()
    var sexImageView = UIImageView()
    
    
    var firstNameLineImageView = UIImageView()
    var lastNameLineImageView = UIImageView()
    var sexLineImageView = UIImageView()
    var ageLineImageView = UIImageView()
    var countryLineImageView = UIImageView()
    var emailLineImageView = UIImageView()
    var passwordLineImageView = UIImageView()
    var rePasswordLineImageView = UIImageView()
    
    var contentView = UIView()
    
    var firstNameWhiteBackground = RoundedView()
    var lastNameWhiteBackground = RoundedView()
    var sexWhiteBackground = RoundedView()
    var ageNamewhiteBackground = RoundedView()
    var countryWhiteBackground = RoundedView()
    var femailWhiteBackground = RoundedView()
    var passwordWhiteBackground = RoundedView()
    var rePasswordWhiteBackground = RoundedView()
    
    var firstNameTextField = UITextField()
    var lastNameTextField = UITextField()
    var ageTextField = UITextField()
    var countryTextField = UITextField()
    var sexTextField = UITextField()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var reEnterPasswordTextField = UITextField()
    
    var activeTextField: UITextField!
    
    var whiteBackgroundViews: [RoundedView] = []
    var lineImageViews: [UIImageView] = []
    
    var constraints: [NSLayoutConstraint] = []
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldDelegates()
        setupViews()
        //Add Observer to know about keyboard appearences
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - TextFieldDelegate
    @objc func keyboardDidShow(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY: CGFloat! = self.activeTextField?.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
            
            if editingTextFieldY > keyboardY - 60 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 60)), width: self.view.bounds.width, height: self.view.bounds.height )
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    
    func setupTextFieldDelegates(){
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        ageTextField.delegate = self
        countryTextField.delegate = self
        sexTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        reEnterPasswordTextField.delegate = self
    }
    
    //MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}

extension RegisterViewController {
    
    func setupViews() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "register")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        imageView.addSubview(contentView)
        
        createInstances()
        
        constraints += [
            
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            whiteBackgroundViews[0].topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            whiteBackgroundViews[0].widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            whiteBackgroundViews[0].heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            whiteBackgroundViews[0].centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

        ]
        
        for index in 1..<whiteBackgroundViews.count {
            whiteBackgroundViews[index].widthAnchor.constraint(equalTo: whiteBackgroundViews[index - 1].widthAnchor).isActive = true
            whiteBackgroundViews[index].heightAnchor.constraint(equalTo: whiteBackgroundViews[index - 1].heightAnchor).isActive = true
            whiteBackgroundViews[index].centerXAnchor.constraint(equalTo: whiteBackgroundViews[index - 1].centerXAnchor).isActive = true
            whiteBackgroundViews[index].topAnchor.constraint(equalTo: whiteBackgroundViews[index - 1].bottomAnchor, constant: 30).isActive = true
        }
        
        NSLayoutConstraint.activate(constraints)

    }
    
    //Layout TextField with icons
    func createFillForm(iconView: UIImageView, textField: UITextField, placeholderText: String, index: Int){
        
        whiteBackgroundViews[index].translatesAutoresizingMaskIntoConstraints = false
        whiteBackgroundViews[index].backgroundColor = UIColor.white
        view.insertSubview(whiteBackgroundViews[index], aboveSubview: imageView)

        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        whiteBackgroundViews[index].addSubview(iconView)

        lineImageViews[index].translatesAutoresizingMaskIntoConstraints = false
        lineImageViews[index].image = UIImage(named: "line")
        lineImageViews[index].contentMode = .scaleAspectFit
        whiteBackgroundViews[index].addSubview(lineImageViews[index])

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholderText
        textField.clearButtonMode = .whileEditing
        whiteBackgroundViews[index].addSubview(textField)
        
        if index != 0 {
            whiteBackgroundViews[index].topAnchor.constraint(equalTo: whiteBackgroundViews[index - 1].bottomAnchor, constant: 10).isActive = true
        }

        constraints += [
            iconView.leadingAnchor.constraint(equalTo: whiteBackgroundViews[index].leadingAnchor, constant: 10),
            iconView.heightAnchor.constraint(equalTo: whiteBackgroundViews[index].heightAnchor, multiplier: 0.4),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
            iconView.centerYAnchor.constraint(equalTo: whiteBackgroundViews[index].centerYAnchor),

            lineImageViews[index].heightAnchor.constraint(equalTo: iconView.heightAnchor, multiplier: 1.1),
            lineImageViews[index].leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 5),
            lineImageViews[index].centerYAnchor.constraint(equalTo: iconView.centerYAnchor),

            textField.leadingAnchor.constraint(equalTo: lineImageViews[index].trailingAnchor, constant: 5),
            textField.centerYAnchor.constraint(equalTo: lineImageViews[index].centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: whiteBackgroundViews[index].trailingAnchor, constant: -10),
            textField.widthAnchor.constraint(equalTo: whiteBackgroundViews[index].widthAnchor, multiplier: 0.77)
        ]
    }
    
    func createInstances() {
        whiteBackgroundViews.append(firstNameWhiteBackground)
        whiteBackgroundViews.append(lastNameWhiteBackground)
        whiteBackgroundViews.append(sexWhiteBackground)
        whiteBackgroundViews.append(ageNamewhiteBackground)
        whiteBackgroundViews.append(countryWhiteBackground)
        whiteBackgroundViews.append(femailWhiteBackground)
        whiteBackgroundViews.append(passwordWhiteBackground)
        whiteBackgroundViews.append(rePasswordWhiteBackground)
        
        lineImageViews.append(firstNameLineImageView)
        lineImageViews.append(lastNameLineImageView)
        lineImageViews.append(sexLineImageView)
        lineImageViews.append(ageLineImageView)
        lineImageViews.append(countryLineImageView)
        lineImageViews.append(emailLineImageView)
        lineImageViews.append(passwordLineImageView)
        lineImageViews.append(rePasswordLineImageView)
        
        firstNameImageView.image = UIImage(named: "user" )
        lastNameImageView.image = UIImage(named: "user")
        ageImageView.image = UIImage(named: "age")
        countryImageView.image = UIImage(named: "country")
        emailImageView.image = UIImage(named: "email")
        passwordImageView.image = UIImage(named: "password")
        reEnterPasswordImageView.image = UIImage(named: "password")
        sexImageView.image = UIImage(named: "male")
        
        createFillForm(iconView: firstNameImageView, textField: firstNameTextField, placeholderText: "First Name", index: 0)
        createFillForm(iconView: lastNameImageView, textField: lastNameTextField, placeholderText: "Last Name", index: 1)
        createFillForm(iconView: sexImageView, textField: sexTextField, placeholderText: "Sex", index: 2)
        createFillForm(iconView: ageImageView, textField: ageTextField, placeholderText: "Age", index: 3)
        createFillForm(iconView: countryImageView, textField: countryTextField, placeholderText: "Select your country", index: 4)
        createFillForm(iconView: emailImageView, textField: emailTextField, placeholderText: "Enter email", index: 5)
        createFillForm(iconView: passwordImageView, textField: passwordTextField, placeholderText: "Enter the password", index: 6)
        createFillForm(iconView: reEnterPasswordImageView, textField: reEnterPasswordTextField, placeholderText: "Reenter the password",index: 7)

    }
}

            
