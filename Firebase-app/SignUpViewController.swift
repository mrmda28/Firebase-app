//
//  SignUpViewController.swift
//  Firebase-app
//
//  Created by Dmitriy Maslennikov on 02/12/2021.
//  Copyright © 2021 Dmitriy Maslennikov. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
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
        dismiss(animated: true, completion: nil)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign Up Page"
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
    
    let fieldConfirmPassword: UITextField = {
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
        field.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.gray])
        return field
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 75/255.0, green: 179/255.0, blue: 75/255.0, alpha: 1.0)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    @objc func signUp() {
        guard fieldEmail.text != "", fieldPassword.text != "", fieldConfirmPassword.text != "" else { return showAlert("Email or password can't be empty.") }
        
        guard fieldPassword.text == fieldConfirmPassword.text else { return showAlert("Passwords do not match.") }
        
        spinner.startAnimating()
        
        FirebaseManager.shared.createUserWithEmail(email: fieldEmail.text, password: fieldPassword.text) { (verified, status) in
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
        view.addSubview(fieldConfirmPassword)
        view.addSubview(signUpButton)
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
            titleLabel.bottomAnchor.constraint(equalTo: fieldEmail.topAnchor, constant: -12)
        ])

        NSLayoutConstraint.activate([
            fieldEmail.heightAnchor.constraint(equalToConstant: 44),

            fieldEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            fieldEmail.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            fieldEmail.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            fieldEmail.bottomAnchor.constraint(equalTo: fieldPassword.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            fieldPassword.heightAnchor.constraint(equalToConstant: 44),
            
            fieldPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fieldPassword.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            fieldPassword.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            fieldPassword.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            fieldConfirmPassword.heightAnchor.constraint(equalToConstant: 44),
            
            fieldConfirmPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fieldConfirmPassword.topAnchor.constraint(equalTo: fieldPassword.bottomAnchor, constant: 12),
            fieldConfirmPassword.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            fieldConfirmPassword.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalToConstant: 44),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: fieldConfirmPassword.bottomAnchor, constant: 12),
            signUpButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            signUpButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 90),
            spinner.widthAnchor.constraint(equalToConstant: 90),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
