//
//  ViewController.swift
//  TestTaskRegistrationForm
//
//  Created by JigSaw on 01.07.2018.
//  Copyright © 2018 poulkravtsoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView = UIImageView()
    var buttonsView = UIVisualEffectView()
    var registerButton = UIButton()
    var loginButton = UIButton()
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    var constraints: [NSLayoutConstraint] = []
    var logoImageView = UIImageView()
    var userImageView = UIImageView()
    var lineImageView = UIImageView()
    var lineImageViewPassword = UIImageView()
    var passwordImageView = UIImageView()
    let userWhiteBackground = RoundedView()
    let passwordWhiteBackground = RoundedView()
   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
    }
    
}

extension ViewController {
    func setupViews() {
    
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "background")
        view.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: .regular)
        buttonsView = UIVisualEffectView(effect: blurEffect)
        buttonsView.alpha = 0.95
        buttonsView.layer.cornerRadius = 10.0
        buttonsView.layer.masksToBounds = true
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(buttonsView, aboveSubview: imageView)
        
        userWhiteBackground.translatesAutoresizingMaskIntoConstraints = false
        userWhiteBackground.backgroundColor = .white
        view.insertSubview(userWhiteBackground, aboveSubview: buttonsView)
        
        passwordWhiteBackground.translatesAutoresizingMaskIntoConstraints = false
        passwordWhiteBackground.backgroundColor = .white
        view.insertSubview(passwordWhiteBackground, aboveSubview: buttonsView)
        
        logoImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(logoImageView, aboveSubview: imageView)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.titleLabel?.text = "Register"
        view.insertSubview(registerButton, aboveSubview: buttonsView)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.titleLabel?.text = "Login"
        view.insertSubview(loginButton, aboveSubview: buttonsView)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.adjustsFontSizeToFitWidth = true
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.placeholder = "Username"
        view.insertSubview(usernameTextField, aboveSubview: userWhiteBackground)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.isSecureTextEntry = true
        view.insertSubview(passwordTextField, aboveSubview: passwordWhiteBackground)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFit
        userImageView.image = UIImage(named: "user")
        view.insertSubview(userImageView, aboveSubview: userWhiteBackground)
        
        lineImageView.translatesAutoresizingMaskIntoConstraints = false
        lineImageView.contentMode = .scaleAspectFit
        lineImageView.image = UIImage(named: "line")
        view.insertSubview(lineImageView, aboveSubview: userWhiteBackground)
        
        passwordImageView.translatesAutoresizingMaskIntoConstraints = false
        passwordImageView.contentMode = .scaleAspectFit
        passwordImageView.image = UIImage(named: "password")
        view.insertSubview(passwordImageView, aboveSubview: passwordWhiteBackground)
        
        lineImageViewPassword.translatesAutoresizingMaskIntoConstraints = false
        lineImageViewPassword.contentMode = .scaleAspectFit
        lineImageViewPassword.image = UIImage(named: "line")
        view.insertSubview(lineImageViewPassword, aboveSubview: passwordWhiteBackground)
        
        constraints += [
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.height * 0.08),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            buttonsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            buttonsView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -view.bounds.size.height * 0.08),
            
            userWhiteBackground.topAnchor.constraint(equalTo: buttonsView.topAnchor, constant: 20),
            userWhiteBackground.widthAnchor.constraint(equalTo: buttonsView.widthAnchor, multiplier: 0.9),
            userWhiteBackground.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
            userWhiteBackground.heightAnchor.constraint(equalTo: buttonsView.heightAnchor, multiplier: 0.2),
            
            passwordWhiteBackground.topAnchor.constraint(equalTo: userWhiteBackground.bottomAnchor, constant: 20),
            passwordWhiteBackground.widthAnchor.constraint(equalTo: userWhiteBackground.widthAnchor),
            passwordWhiteBackground.heightAnchor.constraint(equalTo: userWhiteBackground.heightAnchor),
            passwordWhiteBackground.centerXAnchor.constraint(equalTo: userWhiteBackground.centerXAnchor),
            
            userImageView.centerYAnchor.constraint(equalTo: userWhiteBackground.centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: userWhiteBackground.leadingAnchor, constant: 10),
            userImageView.heightAnchor.constraint(equalTo: userWhiteBackground.heightAnchor, multiplier: 0.4),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            
            lineImageView.heightAnchor.constraint(equalTo: userImageView.heightAnchor, multiplier: 1.1),
            lineImageView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            lineImageView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 5),
            
            usernameTextField.trailingAnchor.constraint(equalTo: userWhiteBackground.trailingAnchor, constant: -10),
            usernameTextField.leadingAnchor.constraint(equalTo: lineImageView.trailingAnchor, constant: 5),
            usernameTextField.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),

            passwordImageView.centerYAnchor.constraint(equalTo: passwordWhiteBackground.centerYAnchor),
            passwordImageView.leadingAnchor.constraint(equalTo: passwordWhiteBackground.leadingAnchor, constant: 10),
            passwordImageView.heightAnchor.constraint(equalTo: userImageView.heightAnchor),
            passwordImageView.widthAnchor.constraint(equalTo: passwordImageView.heightAnchor),
            
            lineImageViewPassword.heightAnchor.constraint(equalTo: passwordImageView.heightAnchor, multiplier: 1.1),
            lineImageViewPassword.centerYAnchor.constraint(equalTo: passwordImageView.centerYAnchor),
            lineImageViewPassword.leadingAnchor.constraint(equalTo: passwordImageView.trailingAnchor, constant: 5),

            passwordTextField.centerYAnchor.constraint(equalTo: passwordImageView.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: lineImageViewPassword.trailingAnchor, constant: 5),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordWhiteBackground.trailingAnchor, constant: -10)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}

