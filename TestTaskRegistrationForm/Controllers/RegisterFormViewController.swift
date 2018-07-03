//
//  RegisterFormViewController.swift
//  TestTaskRegistrationForm
//
//  Created by JigSaw on 02.07.2018.
//  Copyright © 2018 poulkravtsoff. All rights reserved.
//

import UIKit

class RegisterFormViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    var backgroundImageView = UIImageView()
    var firstNameTextField = RoundedTextField()
    var lastNameTextField = RoundedTextField()
    var emailTextField = RoundedTextField()
    var passwordTextField = RoundedTextField()
    var confirmPasswordTextField = RoundedTextField()
    var countriesTextField = RoundedTextField()
    var registerButton = RoundedButton()
    var contentView = UIView()
    var buttonView = UIView()
    
    var countries = [String]()
    let countriesLoader = CountriesLoader()
    
    var emailTableHintList = UITableView()
    
    var domains = ["@yandex.ru", "@gmail.co.uk", "@gmail.com", "@hotbox.ru", "@hotmail.com", "@inbox.ru", "@list.ru", "@mail.ru", "@mail.com", "msn.com", "@rambler.ru", "@yahoo.com", "@icloud.com"]
    var domainsList: [String] = []
    
    var activeTextField: UITextField!
    
    var constraints: [NSLayoutConstraint] = []
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        let countryPicker = UIPickerView()
        countryPicker.alpha = 0.5
        countriesTextField.inputView = countryPicker
        countryPicker.delegate = self
        view.backgroundColor = .blue
        setupViews()
        
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //TableViewhint description
        emailTableHintList.isHidden = true
        for domain in domains {
            domainsList.append(domain)
        }
        emailTextField.addTarget(self, action: #selector(searchResults), for: .editingChanged)
        loadCountries()
        print("\(countries)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - PickerViewDataSource
    
    
    func setupDelegates(){
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        countriesTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        emailTableHintList.delegate = self
        emailTableHintList.dataSource = self
    }
    
}
//MARK: - PickerView dataSource
extension RegisterFormViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countriesTextField.text = countries[row]
    }
}

//MARK: TextViewDelegate
extension RegisterFormViewController{
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
    
    @objc func keyboardDidShow(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY: CGFloat! = self.activeTextField?.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
            
            if editingTextFieldY > keyboardY - 250 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 250)), width: self.view.bounds.width, height: self.view.bounds.height )
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
}

//MARK: - TableViewDataSource
extension RegisterFormViewController {
    
    @objc func searchResults(_ textField: UITextField){
        domains.removeAll()
        if textField.text?.count != 0 {
            for domain in domainsList {
                if let domainToSearch = textField.text  {
                    if domainToSearch.contains("@") {
                        emailTableHintList.isHidden = false
                        let separatedArray = domainToSearch.components(separatedBy: "@")
                        let userName = separatedArray[0]
                        let domainName = "@" + separatedArray[1]
                        let range = domain.lowercased().range(of: domainName, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            domains.append(userName + domain)
                        }
                    }else{
                        emailTableHintList.isHidden = true
                    }
                }
            }
        }else{
            for domain in domainsList {
                domains.append(domain)
            }
            emailTableHintList.isHidden = true
        }
        emailTableHintList.reloadData()
        if emailTableHintList.visibleCells.count == 0{
            emailTableHintList.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "domain")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "domain")
        }
        cell?.textLabel?.text = domains[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        emailTextField.text = domains[indexPath.row]
        emailTableHintList.isHidden = true
    }
}

//MARK: - Setup Constraints
extension RegisterFormViewController {
    func setupViews() {
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "register")
        backgroundImageView.contentMode = .scaleToFill
        view.addSubview(backgroundImageView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        view.addSubview(contentView)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .clear
        view.addSubview(buttonView)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.backgroundColor = .white
        firstNameTextField.placeholder = "First Name"
        contentView.addSubview(firstNameTextField)
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.backgroundColor = .white
        lastNameTextField.placeholder = "Last Name"
        contentView.addSubview(lastNameTextField)
        
        countriesTextField.translatesAutoresizingMaskIntoConstraints = false
        countriesTextField.backgroundColor = .white
        countriesTextField.placeholder = "Your Country"
        contentView.addSubview(countriesTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.backgroundColor = .white
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholder = "Email"
        contentView.addSubview(emailTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .white
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        contentView.addSubview(passwordTextField)
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.backgroundColor = .white
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.placeholder = "Confirm the password"
        contentView.addSubview(confirmPasswordTextField)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.backgroundColor = UIColor.lightGray
        registerButton.setTitle("Register", for: .normal)
        buttonView.addSubview(registerButton)
        
        emailTableHintList.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(emailTableHintList, aboveSubview: emailTextField)
        
        let constant: CGFloat = 25
        
        constraints += [
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.height * 0.07),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            buttonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            registerButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            registerButton.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.5),
            registerButton.heightAnchor.constraint(equalTo: buttonView.heightAnchor, multiplier: 0.6),
            
            firstNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant),
            firstNameTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            firstNameTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.11),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.topAnchor),
            lastNameTextField.heightAnchor.constraint(equalTo: firstNameTextField.heightAnchor),
            lastNameTextField.widthAnchor.constraint(equalTo: firstNameTextField.widthAnchor),
            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant),
            
            countriesTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: constant),
            countriesTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            countriesTextField.trailingAnchor.constraint(equalTo: lastNameTextField.trailingAnchor),
            countriesTextField.heightAnchor.constraint(equalTo: firstNameTextField.heightAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: countriesTextField.bottomAnchor, constant: constant),
            emailTextField.heightAnchor.constraint(equalTo: firstNameTextField.heightAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: lastNameTextField.trailingAnchor),
            
            emailTableHintList.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            emailTableHintList.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            emailTableHintList.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            emailTableHintList.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: constant),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: constant),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - Parse plist countries
extension RegisterFormViewController {
    func loadCountries() {
        do {
            countries = try countriesLoader.loadCountries()
        }catch{
            switch error {
            case LoaderError.dictionaryFailed:
                print("Could not load Dictionary")
            case LoaderError.pathFailed:
                print("Could not find valid file at path")
            default:
                print("Unknown error")
            }
        }
    }
}

