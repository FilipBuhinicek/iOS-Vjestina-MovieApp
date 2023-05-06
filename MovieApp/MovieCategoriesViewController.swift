import Foundation
import PureLayout
import UIKit
import MovieAppData
import SDWebImage

class MovieCategoriesViewController: UIViewController {
    private var moviesSection: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    let movies = MovieUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        moviesSection.collectionViewLayout.invalidateLayout()
    }
    
    func buildView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        flowLayout = UICollectionViewFlowLayout()
        moviesSection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout )
        view.addSubview(moviesSection)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        let spacing:CGFloat = 40
        flowLayout.minimumLineSpacing = CGFloat(spacing)
    }
    
    func defineLayoutForViews() {
        flowLayout.scrollDirection = .vertical
        moviesSection.autoPinEdge(toSuperviewSafeArea: .top, withInset: 25)
        moviesSection.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        moviesSection.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 45)
        moviesSection.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        moviesSection.register(MovieCategoryCell.self, forCellWithReuseIdentifier: "MovieCategoryCell")
        moviesSection.dataSource = self
        moviesSection.delegate = self
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
            cell.set(title: "What's popular", items: movies.popularMovies)
        }
        if indexPath.item == 1 {
            cell.set(title: "Free to Watch", items: movies.freeToWatchMovies)
        }
        if indexPath.item == 2 {
            cell.set(title: "Trending", items: movies.trendingMovies)
        }
        cell.layoutIfNeeded()
        cell.collectionViewCell.tag = indexPath.item
        cell.collectionViewCell.delegate = self
        cell.collectionViewCell.dataSource = cell
        return cell
    }
}

extension MovieCategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 223)
    }
}
