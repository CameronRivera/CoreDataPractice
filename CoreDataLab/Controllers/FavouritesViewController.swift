//
//  FavouritesViewController.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    private let favouritesView = FavouritesView()
    private let currentUser: User
    private var favourites = [Favourite](){
        didSet{
            favouritesView.tableView.reloadData()
            checkForEmptiness()
        }
    }
    
    init(_ user: User){
        currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView(){
        view = favouritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpTableView()
    }
    
    private func setUp(){
        fetchFavourites()
        CoreDataManager.shared.delegate = self
        view.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Favourites"
    }
    
    private func setUpTableView(){
        favouritesView.tableView.delegate = self
        favouritesView.tableView.dataSource = self
        favouritesView.tableView.register(FavouriteCell.self, forCellReuseIdentifier: "favouriteCell")
        checkForEmptiness()
    }
    
    private func checkForEmptiness(){
        if favourites.count <= 0 {
            favouritesView.tableView.separatorStyle = .none
            favouritesView.tableView.backgroundView = EmptyStateView("No Favourites", "Use the search bar in the search tab to find some pictures to favourite.")
        } else {
            favouritesView.tableView.separatorStyle = .singleLine
            favouritesView.tableView.backgroundView = nil
        }
    }
    
    private func fetchFavourites(){
        
        do {
            favourites = try CoreDataManager.shared.fetchFavourites(currentUser.name!)
        } catch {
            showAlert("Error Fetching Favourites", error.localizedDescription)
        }
        
    }

}

extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as? FavouriteCell else {
            fatalError("Could not dequeue cell as a favouriteCell")
        }
        xCell.configureCell(favourites[indexPath.row])
        return xCell
    }
    
}

extension FavouritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let yCell = tableView.cellForRow(at: indexPath) as? FavouriteCell, let image = yCell.favouriteImageView.image else {
            fatalError("Could not downcast cell to FavouriteCell")
        }
        
        let detailVC = DetailViewController(nil, image, SeguedFrom.favourites, favourites[indexPath.row], currentUser)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension FavouritesViewController: CoreDataManagerDelegate {
    
    func updatedFavourites(_ coreDataManager: CoreDataManager) {
        do {
            favourites = try CoreDataManager.shared.fetchFavourites(currentUser.name!)
        } catch {
            showAlert("Error Fetching Favourites", error.localizedDescription)
        }
    }
    
}
