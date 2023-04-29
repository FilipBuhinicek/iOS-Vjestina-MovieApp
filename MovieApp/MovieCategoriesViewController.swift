//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 09.04.2023..
//

import Foundation
import PureLayout
import UIKit
import MovieAppData
import SDWebImage

class MovieCategoriesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    let details = MovieUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func createViews() {
        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout )
        view.addSubview(collectionView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        collectionView.register(MovieCategoryCell.self, forCellWithReuseIdentifier: "MovieCategoryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let spacing:CGFloat = 40
        flowLayout.minimumLineSpacing = CGFloat(spacing)
    }
    
    func defineLayoutForViews() {
        flowLayout.scrollDirection = .vertical
        collectionView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 25)
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 45)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
    }

    func buildView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
}

extension MovieCategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryCell", for: indexPath) as? MovieCategoryCell else { return UICollectionViewCell() }

        if indexPath.item == 0 {
            cell.set(title: "What's popular", items: details.popularMovies)
        }
        if indexPath.item == 1 {
            cell.set(title: "Free to Watch", items: details.freeToWatchMovies)
        }
        if indexPath.item == 2 {
            cell.set(title: "Trending", items: details.trendingMovies)
        }

        cell.layoutIfNeeded()
        
        return cell
    }
}

extension MovieCategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 223)
    }
}
