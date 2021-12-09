//
//  ProfileViewController.swift
//  Firebase-app
//
//  Created by Dmitriy Maslennikov on 02/12/2021.
//  Copyright © 2021 Dmitriy Maslennikov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
        label.text = "Profile Page"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
    }
    

    private func setupViews() {
                    
        view.addSubview(exitButton)
        view.addSubview(titleLabel)
    }
                
    private func setupConstraints() {
                
        let safeArea = view.safeAreaLayoutGuide
//        let viewFrame = view.bounds
                    
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            exitButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 12)
        ])
    }
}
