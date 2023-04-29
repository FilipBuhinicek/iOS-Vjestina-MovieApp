//
//  MovieListCell.swift
//  MovieApp
//
//  Created by endava-bootcamp on 09.04.2023..
//

import Foundation
import PureLayout
import MovieAppData
import SDWebImage

class MovieCategoryCell: UICollectionViewCell {
    var indexOf: Int!
    private var collectionViewCell: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
//    let details = MovieUseCase()
    private var title = UILabel()
    private var movies: [MovieModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayoutForViwes()
    }

    func set(title: String, items: [MovieModel]) {
        self.title.text = title
        movies = items

//        collectionViewCell.reloadData()
    }
    
    func createViews() {
        self.addSubview(title)
        
        flowLayout = UICollectionViewFlowLayout()
        collectionViewCell = UICollectionView(frame: .zero, collectionViewLayout: flowLayout )
        self.addSubview(collectionViewCell)
    }
    
    func styleViews() {
        self.backgroundColor = .white
        title.textColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        title.font = .boldSystemFont(ofSize: 20)
        
        collectionViewCell.register(MovieCategoryListCell.self, forCellWithReuseIdentifier: "MovieCategoryListCell")
        collectionViewCell.dataSource = self
        collectionViewCell.delegate = self
        
        let spacing:CGFloat = 8
        flowLayout.minimumInteritemSpacing = CGFloat(spacing)
    }
    
    func defineLayoutForViwes() {
        title.autoSetDimension(.width, toSize: 358)
        title.autoPinEdge(toSuperviewEdge: .top)
        title.autoPinEdge(toSuperviewEdge: .leading)
      
        flowLayout.scrollDirection = .horizontal
        collectionViewCell.autoPinEdge(toSuperviewEdge: .top, withInset: 44)
        collectionViewCell.autoPinEdge(toSuperviewEdge: .leading)
        collectionViewCell.autoPinEdge(toSuperviewEdge: .bottom)
        collectionViewCell.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
//        var count: Int!
//        if indexOf == 0 {
//            count = details.popularMovies.count
//        }
//        if indexOf == 1 {
//            count = details.freeToWatchMovies.count
//        }
//        if indexOf == 2 {
//            count = details.trendingMovies.count
//        }
//        return count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryListCell", for: indexPath) as? MovieCategoryListCell,
            self.movies.count > indexPath.item
        else { return UICollectionViewCell() }

        cell.configureCell(movie: self.movies[indexPath.item])
        return cell
//        if indexOf == 0 {
//            cell?.configureCell(movie: details.popularMovies[indexPath.item])
//        }
//        if indexOf == 1 {
//            cell?.configureCell(movie: details.freeToWatchMovies[indexPath.item])
//        }
//        if indexOf == 2 {
//            cell?.configureCell(movie: details.trendingMovies[indexPath.item])
//        }
//        return cell!
    }
}

extension MovieCategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 122, height: 179)
    }
}

