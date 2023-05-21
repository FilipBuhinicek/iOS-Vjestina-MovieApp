import Foundation
import PureLayout
import UIKit
import MovieAppData
import SDWebImage

class MovieListViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    let moviesInfo = MovieUseCase()
    private var router: AppRouter!
    private var viewModel = MovieListViewModel()
    
    convenience init(router: AppRouter){
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        navigationItem.title = "Movie List"
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
        let spacing:CGFloat = 12
        flowLayout.minimumLineSpacing = CGFloat(spacing)
    }
    
    func defineLayoutForViews() {
        flowLayout.scrollDirection = .vertical
        collectionView.autoPinEdgesToSuperviewEdges()
        
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: "MovieListCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .blue
    }

    func buildView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesInfo.allMovies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        let movie = moviesInfo.allMovies[indexPath.item]
        cell.configureCell(movie: movie)
        cell.layoutIfNeeded()
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 142)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = moviesInfo.allMovies[indexPath.item]
        router.goToMovieDetails(movie: selectedMovie)
    }
}
