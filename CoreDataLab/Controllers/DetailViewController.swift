//
//  DetailViewController.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

enum SeguedFrom{
    case search
    case favourites
}

import UIKit

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    private let state: SeguedFrom
    private let currentPicture: PixPic?
    private let currentFavourite: Favourite?
    private let currentUser: User
    
    init(_ currentPicture: PixPic?, _ image: UIImage, _ departurePoint: SeguedFrom, _ favourite: Favourite?,_ currentUser: User){
        self.state = departurePoint
        self.currentPicture = currentPicture
        self.detailView.detailImageView.image = image
        self.currentFavourite = favourite
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView(){
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addFavouriteButton()
    }

    private func setUp() {
        detailView.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Detailed View"
        if let picture = currentPicture {
            detailView.tagsLabel.text = picture.tags
        } else if let favourite = currentFavourite {
            detailView.tagsLabel.text = favourite.tags
        }
    }
    
    private func addFavouriteButton(){
        if state == SeguedFrom.search {
            navigationItem.rightBarButtonItem = detailView.favouriteButton
            detailView.favouriteButton.target = self
            detailView.favouriteButton.action = #selector(favouriteButtonPressed)
            detailView.favouriteButton.isEnabled = true
        } else if state == SeguedFrom.favourites {
            navigationItem.rightBarButtonItem = detailView.favouriteButton
            detailView.favouriteButton.setBackgroundImage(UIImage(systemName: "moon.stars.fill"), for: .normal, barMetrics: .default)
            detailView.favouriteButton.isEnabled = false
        }
    }
    
    @discardableResult
    private func createFavourite() -> Favourite {
        guard let detailImage = detailView.detailImageView.image else {
            fatalError("No image shown")
        }
        
        var newFavourite: Favourite?
        let favouriteId = UUID().uuidString
        let resizedImage = UIImageView.resizeImage(originalImage: detailImage, rect: detailView.detailImageView.bounds)
        
        guard let imageData = resizedImage.pngData() else {
            fatalError("Image could not be turned into data.")
        }
        
        do {
            newFavourite = try CoreDataManager.shared.createFavourite(currentPicture?.tags ?? "", favouriteId, imageData, currentUser)
        } catch {
            showAlert("Favourite Creation Error", error.localizedDescription)
        }
        
        return newFavourite!
        
    }
    
    @objc
    private func favouriteButtonPressed(_ sender: UIButton){
        createFavourite()
        showAlert("Added to Favourites", nil)
        detailView.favouriteButton.isEnabled = false
    }
    
}
