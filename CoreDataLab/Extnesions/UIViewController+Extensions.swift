//
//  UIViewController+Extensions.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/11/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

// Alert
extension UIViewController{
    
    func showAlert(_ title: String?, _ message: String?, _ completion: ((UIAlertAction)->())? = nil){
        let alertAction = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertAction.addAction(okAction)
        present(alertAction, animated: true, completion: nil)
    }
    
}

// Scene Change
extension UIViewController {
    
    static func resetWindow(_ viewController: UIViewController){
        
        guard let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate = scene.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            fatalError("Could not reset root view controller.")
        }
        
        window.rootViewController = viewController
    }
    
}
