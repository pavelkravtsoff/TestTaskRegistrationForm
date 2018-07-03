//
//  ThirdViewController.swift
//  TestTaskRegistrationForm
//
//  Created by JigSaw on 03.07.2018.
//  Copyright © 2018 poulkravtsoff. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    //MARK: - Properties
    private var imageView = UIImageView()
    private var blurView = UIView()
    private var mainLabel = RoundedLabel()
    private var exitButton = RoundedButton()
    private var constraints: [NSLayoutConstraint] = []
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Lifecycle app
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    //MARK: - Button Actions
    @objc func backToMainViewController(_ sender: RoundedButton) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let first = main.instantiateViewController(withIdentifier: "FirstVC")
        self.present(first, animated: true, completion: nil)
    }
}
//MARK: - Setup Constraints
extension ThirdViewController {
    func setupViews() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sunset")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 10.0
        blurView.layer.masksToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, aboveSubview: imageView)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        let message = "Congratulations!\n" + "\n" + "Now you are ready to find your soulmate!"
        mainLabel.text = message
        mainLabel.backgroundColor = .clear
        mainLabel.textColor = .black
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 0
        mainLabel.lineBreakMode = .byWordWrapping
        view.insertSubview(mainLabel, aboveSubview: blurView)
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.backgroundColor = UIColor.lightGray
        exitButton.setTitle("Back To main page", for: .normal)
        exitButton.addTarget(self, action: #selector(backToMainViewController(_:)), for: .touchUpInside)
        view.insertSubview(exitButton, aboveSubview: imageView)
        
        
        constraints += [
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurView.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -view.bounds.size.height * 0.1),
            
            mainLabel.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 10),
            mainLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 10),
            mainLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -10),
            mainLabel.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -10),
            
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.widthAnchor.constraint(equalTo: blurView.widthAnchor),
            exitButton.heightAnchor.constraint(equalTo: blurView.heightAnchor, multiplier: 0.5),
            exitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.size.height * 0.1)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
