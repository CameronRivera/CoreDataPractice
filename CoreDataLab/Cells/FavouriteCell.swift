//
//  FavouriteCell.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {
    
    private var imageURL = ""

    public lazy var favouriteImageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    public lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        setUpFavouriteImageViewConstraints()
        setUpTagsLabel()
    }
    
    private func setUpFavouriteImageViewConstraints() {
        addSubview(favouriteImageView)
        favouriteImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([favouriteImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), favouriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), favouriteImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8), favouriteImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0)])
    }
    
    private func setUpTagsLabel() {
        addSubview(tagsLabel)
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tagsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), tagsLabel.leadingAnchor.constraint(equalTo: favouriteImageView.trailingAnchor, constant: 8), tagsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)])
    }
    
    public func configureCell(_ favourite: Favourite){
        
        guard let imageData = favourite.image, let picture = UIImage(data: imageData) else {
            favouriteImageView.image = UIImage(systemName: "questionmark")
            return
        }
        
        favouriteImageView.image = picture
        tagsLabel.text = favourite.tags
        
    }
    
}
