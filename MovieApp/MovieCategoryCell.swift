import Foundation
import PureLayout
import MovieAppData
import SDWebImage

class MovieCategoryCell: UICollectionViewCell {
    var indexOf: Int!
    var collectionViewCell: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    private var title = UILabel()
    private var movies: [MovieModel] = []
    private var router: AppRouter!
    
    convenience init(router: AppRouter){
        self.init()
        self.router = router
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayoutForViwes()
    }

    func set(title: String, items: [MovieModel]) {
        self.title.text = title
        movies = items
    }
    
    func createViews() {
        addSubview(title)
        
        flowLayout = UICollectionViewFlowLayout()
        collectionViewCell = UICollectionView(frame: .zero, collectionViewLayout: flowLayout )
        addSubview(collectionViewCell)
    }
    
    func styleViews() {
        backgroundColor = .white
        title.textColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        title.font = .boldSystemFont(ofSize: 20)
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
        
        collectionViewCell.register(MovieCategoryListCell.self, forCellWithReuseIdentifier: "MovieCategoryListCell")
        collectionViewCell.dataSource = self
        collectionViewCell.delegate = self
        
        let spacing:CGFloat = 8
        flowLayout.minimumInteritemSpacing = CGFloat(spacing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleGoToMovieDetials(movieId: Int){
        let detailsVC = MovieDetailsViewController(movieId: movieId)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension MovieCategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
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
    }
}

extension MovieCategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 122, height: 179)
    }
}

extension MovieCategoryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        handleGoToMovieDetials(movieId: selectedMovie.id)
    }
}
