//
//  MainTabBarController.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    private var currentUser: User
    
    public lazy var searchPhotosController: SearchPhotosViewController = {
        let vc = SearchPhotosViewController(currentUser)
        vc.tabBarItem = UITabBarItem(title: "Search Photos", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return vc
    }()
    
    public lazy var favouritesViewController: FavouritesViewController = {
       let vc = FavouritesViewController(currentUser)
        vc.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "moon.stars"), tag: 2)
        return vc
    }()
    
    init(_ user: User){
        currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: searchPhotosController), UINavigationController(rootViewController: favouritesViewController)]
    }
    
}
