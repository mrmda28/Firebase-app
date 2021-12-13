//
//  MainViewController.swift
//  Firebase-app
//
//  Created by Dmitriy Maslennikov on 01/12/2021.
//  Copyright © 2021 Dmitriy Maslennikov. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    private let firebaseImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Firebase logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Firebase Auth App"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description text"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let signUpButton: UIButton = {
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
    
    @objc private func signUp() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
    }
    
    private let logInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Already have an account?"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
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
        let logInVC = LogInViewController()
        logInVC.modalPresentationStyle = .fullScreen
        present(logInVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        
        view.addSubview(firebaseImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(signUpButton)
        view.addSubview(logInLabel)
        view.addSubview(logInButton)
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        let viewFrame = view.bounds
        
        NSLayoutConstraint.activate([
            firebaseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firebaseImage.widthAnchor.constraint(equalToConstant: viewFrame.width / 2),
            firebaseImage.heightAnchor.constraint(equalToConstant: viewFrame.width / 2),
            
            firebaseImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            descriptionLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            descriptionLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.widthAnchor.constraint(equalToConstant: viewFrame.width - (12 + 12)),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),

            signUpButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            signUpButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            signUpButton.bottomAnchor.constraint(equalTo: logInLabel.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            logInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            logInLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            logInLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            logInLabel.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.widthAnchor.constraint(equalToConstant: viewFrame.width - (12 + 12)),
            logInButton.heightAnchor.constraint(equalToConstant: 44),
            
            logInButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            logInButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12),
            logInButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -12)
        ])
    }
}
