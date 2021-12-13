//
//  ProfileViewController.swift
//  Firebase-app
//
//  Created by Dmitriy Maslennikov on 02/12/2021.
//  Copyright © 2021 Dmitriy Maslennikov. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Profile Page"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.rightViewMode = .always
        field.layer.borderColor = UIColor.darkGray.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.text = "First name"
        field.textColor = UIColor.gray
        field.isEnabled = false
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.rightViewMode = .always
        field.layer.borderColor = UIColor.darkGray.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 10
        field.text = "Last name"
        field.textColor = UIColor.gray
        field.isEnabled = false
        return field
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
        field.text = "Email"
        field.textColor = UIColor.gray
        field.isEnabled = false
        return field
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit profile", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return button
    }()
    
    @objc private func editProfile() {
        
    }
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    @objc private func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            showAlert("Error signing out: \(signOutError)")
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
    }
    

    private func setupViews() {
                    
        view.addSubview(titleLabel)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(emailField)
        view.addSubview(editProfileButton)
        view.addSubview(logOutButton)
        view.addSubview(spinner)
    }
                
    private func setupConstraints() {
                
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: firstNameField.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            firstNameField.heightAnchor.constraint(equalToConstant: 44),
            
            firstNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstNameField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            firstNameField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            firstNameField.bottomAnchor.constraint(equalTo: lastNameField.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            lastNameField.heightAnchor.constraint(equalToConstant: 44),
            
            lastNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastNameField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            lastNameField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            lastNameField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])

        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 44),
            
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 12),
            emailField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            emailField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            editProfileButton.heightAnchor.constraint(equalToConstant: 44),
            
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editProfileButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            logOutButton.heightAnchor.constraint(equalToConstant: 44),
            
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logOutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 90),
            spinner.widthAnchor.constraint(equalToConstant: 90),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
