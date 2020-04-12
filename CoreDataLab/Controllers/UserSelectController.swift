//
//  UserSelectController.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class UserSelectController: UIViewController {

    private let userSelectView = UserSelectView()
    private var selectedUser: User?
    private var users = [User]()
    
    override func loadView(){
        view = userSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        fetchUsers()
        userSelectView.backgroundColor = UIColor.systemBackground
        userSelectView.pickerView.delegate = self
        userSelectView.pickerView.dataSource = self
        userSelectView.userNameTextField.delegate = self
        userSelectView.createNewUserButton.addTarget(self, action: #selector(createNewUserButtonPressed), for: .touchUpInside)
        userSelectView.selectUserButton.addTarget(self, action: #selector(selectUserButtonPressed), for: .touchUpInside)
    }
    
    private func fetchUsers(){
        
        do {
           users = try CoreDataManager.shared.fetchUsers()
        } catch {
            showAlert("Fetch Error", error.localizedDescription)
        }
        
    }
    
    private func createNewUser(_ name: String) -> User {
        
        var newUser: User?
        
        do {
            newUser = try CoreDataManager.shared.createUser(name)
        } catch {
            showAlert("User Creation Error", error.localizedDescription)
        }
        
        return newUser!
    }
    
    private func sceneChange(_ user: User){
        let mainTabVC = MainTabBarController(user)
        UIViewController.resetWindow(mainTabVC)
    }
    
    @objc
    private func createNewUserButtonPressed(_ sender: UIButton){
        guard let textFieldText = userSelectView.userNameTextField.text, !textFieldText.isEmpty else {
            showAlert("Invalid Username", "User name must contain at least one character.")
            return
        }
        let newUser = createNewUser(textFieldText)
        sceneChange(newUser)
    }
    
    @objc
    private func selectUserButtonPressed(_ sender: UIButton){
        guard let currentUser = selectedUser else{
            showAlert("No user selected", "Please select a user from the ones listed below, or create a new user.")
            return
        }
        sceneChange(currentUser)
    }

}

extension UserSelectController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
}

extension UserSelectController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedUser = users[row]
        return users[row].name
    }
    
}

extension UserSelectController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
