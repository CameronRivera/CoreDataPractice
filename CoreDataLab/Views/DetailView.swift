//
//  DetailView.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class DetailView: UIView {

    public lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public lazy var tagsLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var favouriteButton: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.title = ""
        button.setBackgroundImage(UIImage(systemName: "moon.stars"), for: .normal, barMetrics: .default)
        return button
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
        setUpDetailImageViewConstraints()
        setUpTagsLabelConstraints()
    }

    private func setUpDetailImageViewConstraints() {
        addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([detailImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), detailImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), detailImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), detailImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60)])
        
    }
    
    private func setUpTagsLabelConstraints() {
        addSubview(tagsLabel)
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tagsLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 8), tagsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), tagsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
}
