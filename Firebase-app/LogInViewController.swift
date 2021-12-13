//
//  LogInViewController.swift
//  Firebase-app
//
//  Created by Dmitriy Maslennikov on 02/12/2021.
//  Copyright © 2021 Dmitriy Maslennikov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("×", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)
        return button
    }()
    
    @objc private func exit() {
        dismiss(animated: true, completion: nil)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log In Page"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let emailField: UITextField = {
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
    
    private let passwordField: UITextField = {
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
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 37/255.0, green: 25/255.0, blue: 195/255.0, alpha: 1.0)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    @objc private func logIn() {
        guard emailField.text != "", passwordField.text != "" else { return showAlert("Email or password can't be empty.") }

        spinner.startAnimating()

        FirebaseManager.shared.logInWithEmail(email: emailField.text, password: passwordField.text) { (verified, status) in
            if verified == false {
                self.showAlert(status!)
            }
            self.spinner.stopAnimating()
        }
    }
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.layer.cornerRadius = 20
        spinner.color = .label
        spinner.backgroundColor = .systemFill
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private func showAlert(_ message: String) {
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
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(logInButton)
        view.addSubview(spinner)
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            exitButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 44),
            
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emailField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            emailField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            passwordField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            passwordField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            passwordField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalToConstant: 44),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 12),
            logInButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            logInButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 90),
            spinner.widthAnchor.constraint(equalToConstant: 90),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
