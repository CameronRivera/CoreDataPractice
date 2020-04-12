//
//  PhotoCell.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    private var imageString = ""
    
    public lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
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
        setUpImageViewConstraints()
    }
    
    private func setUpImageViewConstraints(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: contentView.topAnchor), imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor), imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    
    public func configureCell(_ picture: PixPic){
        imageString = picture.largeImageURL
        imageView.getPicture(picture.largeImageURL) { [weak self] result in
            switch result {
            case .failure(let netError):
                print("\(netError)")
            case .success(let image):
                if self?.imageString == picture.largeImageURL {
                    DispatchQueue.main.async{
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
}
