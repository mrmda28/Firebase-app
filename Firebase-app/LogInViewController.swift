//
//  LogInViewController.swift
//  Firebase-app
//
//  Created by Dmitriy Maslennikov on 02/12/2021.
//  Copyright © 2021 Dmitriy Maslennikov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("×", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)
        return button
    }()
    
    @objc func exit() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        dismiss(animated: true, completion: nil)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log In Page"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    let fieldEmail: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.rightViewMode = .always
        field.layer.borderColor = UIColor.darkGray.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.gray])
        return field
    }()
    
    let fieldPassword: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.rightViewMode = .always
        field.layer.borderColor = UIColor.darkGray.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.isSecureTextEntry = true
        field.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.gray])
        return field
    }()
    
    let logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 75/255.0, green: 179/255.0, blue: 75/255.0, alpha: 1.0)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    @objc func logIn() {
        spinner.startAnimating()
        FirebaseManager.shared.logInWithEmail(email: fieldEmail.text, password: fieldPassword.text) { (verified, status) in
            if verified == true {
                let profileVC = ProfileViewController()
                profileVC.titleLabel.text = status
                profileVC.modalPresentationStyle = .fullScreen
                self.present(profileVC, animated: true, completion: nil)
            } else {
                self.showAlert(status)
            }
            self.spinner.stopAnimating()
        }
    }
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.layer.cornerRadius = 20
        spinner.color = .label
        spinner.backgroundColor = .systemFill
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    func showAlert(_ message: String) {
      let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      present(alert, animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        
        view.addSubview(exitButton)
        view.addSubview(titleLabel)
        view.addSubview(fieldEmail)
        view.addSubview(fieldPassword)
        view.addSubview(logInButton)
        view.addSubview(spinner)
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
//        let viewFrame = view.bounds
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            exitButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: fieldEmail.topAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            fieldEmail.heightAnchor.constraint(equalToConstant: 44),
            
            fieldEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fieldEmail.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            fieldEmail.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            fieldEmail.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            fieldPassword.heightAnchor.constraint(equalToConstant: 44),
            
            fieldPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fieldPassword.topAnchor.constraint(equalTo: fieldEmail.bottomAnchor, constant: 12),
            fieldPassword.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            fieldPassword.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalToConstant: 44),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logInButton.topAnchor.constraint(equalTo: fieldPassword.bottomAnchor, constant: 12),
            logInButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            logInButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 90),
            spinner.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
}
