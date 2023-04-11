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

class MovieListViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    let details = MovieUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    func createViews() {
        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout )
        view.addSubview(collectionView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: "MovieListCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let spacing:CGFloat = 12
        flowLayout.minimumLineSpacing = CGFloat(spacing)
    }
    
    func defineLayoutForViews() {
        flowLayout.scrollDirection = .vertical
        collectionView.autoPinEdge(toSuperviewEdge: .top, withInset: 68)
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 58)
    }

    func buildView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        details.allMovies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCell?
        let movie = details.allMovies[indexPath.item]
        cell?.configureCell(movie: movie)
        cell?.layoutIfNeeded()
        return cell!
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 142)
    }
}
