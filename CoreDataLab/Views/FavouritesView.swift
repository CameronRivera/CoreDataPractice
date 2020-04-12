//
//  FavouritesViewController.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class FavouritesView: UIView {
    
    public lazy var tableView: UITableView = {
       let tv = UITableView()
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpTableViewConstraints()
    }
    
    private func setUpTableViewConstraints(){
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor), tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor), tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }

}
