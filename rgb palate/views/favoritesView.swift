//
//  favoritesView.swift
//  rgb palate
//
//  Created by Max Gillespie on 11/30/18.
//  Copyright © 2018 Max Gillespie. All rights reserved.
//

import UIKit

class favoritesView: UIViewController, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "favorites"
        
        setupFavoritesPage()
    }
    
    // visual setup
    func setupFavoritesPage() {
        
    }
    
    // collection view support
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        return cell
    }
}
