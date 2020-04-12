//
//  UserSelectView.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class UserSelectView: UIView {
    
    public lazy var directionsLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "Create a new user or select one from below."
        return label
    }()
    
    public lazy var userNameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = " Enter new username here"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    public lazy var createNewUserButton: UIButton = {
       let button = UIButton()
        button.setTitle("Create New User", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    public lazy var selectUserButton: UIButton = {
       let button = UIButton()
        button.setTitle("Select Current User", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpDirectionsLabelConstraints()
        setUpUserNameTextFieldConstraints()
        setUpCreateNewUserButtonConstraints()
        setUpPickerViewConstraints()
        setUpSelectUserButtonConstraints()
    }
    
    private func setUpDirectionsLabelConstraints(){
        addSubview(directionsLabel)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([directionsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), directionsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), directionsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func setUpUserNameTextFieldConstraints() {
        addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([userNameTextField.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 20), userNameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), userNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), userNameTextField.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpCreateNewUserButtonConstraints() {
        addSubview(createNewUserButton)
        createNewUserButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([createNewUserButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20), createNewUserButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setUpPickerViewConstraints() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pickerView.topAnchor.constraint(equalTo: createNewUserButton.bottomAnchor, constant: 50), pickerView.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setUpSelectUserButtonConstraints() {
        addSubview(selectUserButton)
        selectUserButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([selectUserButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20), selectUserButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
}
