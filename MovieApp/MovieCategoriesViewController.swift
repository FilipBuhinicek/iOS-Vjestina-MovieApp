import Foundation
import PureLayout
import UIKit
import MovieAppData
import SDWebImage

class MovieCategoriesViewController: UIViewController {
    private var moviesSection: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    let movies = MovieUseCase()
    private var router: AppRouter
    private var viewModel = MovieCategoriesViewModel()
    
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        
        navigationItem.title = "Movie List"
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
        moviesSection.autoPinEdge(toSuperviewEdge: .top)
        moviesSection.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        moviesSection.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        moviesSection.autoPinEdge(toSuperviewEdge: .bottom)
        
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
        cell.delegate = self
        cell.collectionViewCell.delegate = cell
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

extension MovieCategoriesViewController: MovieCategoryCellDelegate {
    func movieCategoryCell(_ cell: MovieCategoryCell, didSelectMovie movie: MovieModel) {
        router.goToMovieDetails(movie: movie)
    }
}
