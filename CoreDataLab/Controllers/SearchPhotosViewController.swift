//
//  SearchPhotosViewController.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class SearchPhotosViewController: UIViewController {

    private let searchPhotosView = SearchPhotosView()
    private let currentUser: User
    
    private var pics = [PixPic](){
        didSet{
            DispatchQueue.main.async{
                self.searchPhotosView.collectionView.reloadData()
                self.checkForEmptiness()
            }
        }
    }
    
    private var searchQuery = "" {
        didSet {
            getPhotos(searchQuery)
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
        view = searchPhotosView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        searchPhotosView.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Search"
        searchPhotosView.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        searchPhotosView.collectionView.delegate = self
        searchPhotosView.collectionView.dataSource = self
        searchPhotosView.searchBar.delegate = self
        checkForEmptiness()
    }
    
    private func checkForEmptiness(){
        if pics.count <= 0 {
            searchPhotosView.collectionView.backgroundView = EmptyStateView("No Results Found", "Use the search bar above to search for photos.")
        } else {
            searchPhotosView.collectionView.backgroundView = nil
        }
    }
    
    private func getPhotos(_ query: String){
        PixAPI.getPhotos(query) { [weak self] result in
            switch result {
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Pix Retrieval Error", "\(netError)")
                }
            case .success(let pictures):
                self?.pics = pictures
            }
        }
    }

}

extension SearchPhotosViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("Could not dequeue cell as a photoCell.")
        }
        
        xCell.configureCell(pics[indexPath.row])
        return xCell
    }
}

extension SearchPhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = searchPhotosView.collectionView.bounds.size
        return CGSize(width: size.width * 0.9, height: size.height * 0.8)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let yCell = searchPhotosView.collectionView.cellForItem(at: indexPath) as? PhotoCell, let cellImage = yCell.imageView.image else {
            fatalError("Could not dequeue cell as a photoCell.")
        }
        let detailVC = DetailViewController(pics[indexPath.row], cellImage, SeguedFrom.search, nil, currentUser)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchPhotosViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            showAlert("Invalid Search Query", nil)
            return
        }
        searchQuery = searchText
    }
    
}
