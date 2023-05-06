import Foundation
import PureLayout
import MovieAppData

class MovieDetailsViewController: UIViewController {
    private var myImageView: UIImageView!
    private var ratingLabel: UILabel!
    private var userScoreLabel: UILabel!
    private var nameLabel: UILabel!
    private var yearLabel: UILabel!
    private var genreLabel: UILabel!
    private var favouriteButton: UIButton!
    private var overviewLabel: UILabel!
    private var overviewTextView: UITextView!
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    private var details2 = MovieUseCase().getDetails(id: 111161)
    private var details: MovieDetailsModel!
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    func buildView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    init(movieId: Int) {
        super.init(nibName: nil, bundle: nil)
        details = MovieUseCase().getDetails(id: movieId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        
        navigationItem.title = "Movie Details"
    }
    
    func createViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        myImageView = UIImageView()
        contentView.addSubview(myImageView)
        
        ratingLabel = UILabel()
        myImageView.addSubview(ratingLabel)

        userScoreLabel = UILabel()
        myImageView.addSubview(userScoreLabel)
        
        nameLabel = UILabel()
        myImageView.addSubview(nameLabel)
        
        yearLabel = UILabel()
        myImageView.addSubview(yearLabel)
        
        genreLabel = UILabel()
        myImageView.addSubview(genreLabel)
        
        favouriteButton = UIButton()
        myImageView.addSubview(favouriteButton)
        
        overviewLabel = UILabel()
        contentView.addSubview(overviewLabel)
        
        overviewTextView = UITextView()
        contentView.addSubview(overviewTextView)
        
        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout )
        contentView.addSubview(collectionView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        guard let url = details?.imageUrl else { return }
        myImageView.loadFrom(URLAddress: url)
        
        ratingLabel.textColor = .white
        let stringText = String(Double(details?.rating ?? 0.0))
        ratingLabel.text = stringText
        ratingLabel.font = .boldSystemFont(ofSize: 14)
        
        userScoreLabel.textColor = .white
        userScoreLabel.text = "User score"
        userScoreLabel.font = .systemFont(ofSize: 12)
        
        nameLabel.textColor = .white
        nameLabel.text = details?.name
        nameLabel.font = .boldSystemFont(ofSize: 24)
        
        yearLabel.textColor = .white
        guard let stringDatum = details?.releaseDate else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: stringDatum) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let formattedDate = dateFormatter.string(from: date)
            yearLabel.text = formattedDate + " (US)"
        }
        yearLabel.font = .systemFont(ofSize: 12)
        
        genreLabel.textColor = .white
        var string = ""
        let length: Int = details?.categories.count ?? 0
        for i in 0..<length {
            if details?.categories[i] == MovieCategoryModel.action {
                string = string + "Action, "
            }
            if details?.categories[i] == MovieCategoryModel.adventure {
                string = string + "Adventure, "
            }
            if details?.categories[i] == MovieCategoryModel.comedy {
                string = string + "Comedy, "
            }
            if details?.categories[i] == MovieCategoryModel.crime {
                string = string + "Crime, "
            }
            if details?.categories[i] == MovieCategoryModel.drama {
                string = string + "Drama, "
            }
            if details?.categories[i] == MovieCategoryModel.fantasy {
                string = string + "Fantasy, "
            }
            if details?.categories[i] == MovieCategoryModel.romance {
                string = string + "Romance, "
            }
            if details?.categories[i] == MovieCategoryModel.scienceFiction {
                string = string + "Science fiction, "
            }
            if details?.categories[i] == MovieCategoryModel.thriller {
                string = string + "Thriller, "
            }
            if details?.categories[i] == MovieCategoryModel.western {
                string = string + "Western, "
            }
        }
        let duration = formatTime(minutes: details?.duration ?? 0)
        string = string.trimmingCharacters(in: [" ", ","])
        string.append(" ")
        string.append(duration)
        genreLabel.text = string
        genreLabel.font = .systemFont(ofSize: 12)
        
        favouriteButton.alpha = 0.6
        favouriteButton.layer.backgroundColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1).cgColor
        favouriteButton.layer.cornerRadius = 16
        let image = UIImage(systemName: "star")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 9, y: 10, width: 14, height: 13)
        imageView.tintColor = .white
        favouriteButton.addSubview(imageView)
        
        overviewLabel.textColor = .black
        overviewLabel.text = "Overview"
        overviewLabel.font = .boldSystemFont(ofSize: 20)
        
        overviewTextView.textColor = .black
        overviewTextView.text = details?.summary
        overviewTextView.font = .systemFont(ofSize: 14)
        overviewTextView.isEditable = false
    }
    
    func defineLayoutForViews() {
        scrollView.autoPinEdgesToSuperviewEdges()
        
        contentView.autoMatch(.width, to: .width, of: scrollView)
        contentView.autoPinEdge(toSuperviewEdge: .top)
        contentView.autoPinEdge(toSuperviewEdge: .bottom)
        contentView.autoPinEdge(toSuperviewEdge: .trailing)
        contentView.autoPinEdge(toSuperviewEdge: .leading)
        
        myImageView.autoSetDimension(.height, toSize: 327)
        myImageView.autoPinEdge(toSuperviewSafeArea: .leading)
        myImageView.autoPinEdge(toSuperviewSafeArea: .trailing)
        myImageView.autoPinEdge(toSuperviewSafeArea: .top)
        
        ratingLabel.autoSetDimensions(to: CGSize(width: 22, height: 19))
        ratingLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        ratingLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 134)
        
        userScoreLabel.autoSetDimensions(to: CGSize(width: 72, height: 17))
        userScoreLabel.autoPinEdge(.leading, to: .trailing, of: ratingLabel, withOffset: 8)
        userScoreLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 135)
        
        nameLabel.autoSetDimensions(to: CGSize(width: 350, height: 34))
        nameLabel.autoPinEdge(.top, to: .bottom, of: userScoreLabel, withOffset: 17)
        nameLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        yearLabel.autoSetDimensions(to: CGSize(width: 105, height: 20))
        yearLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16)
        yearLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        genreLabel.autoSetDimensions(to: CGSize(width: 258, height: 20))
        genreLabel.autoPinEdge(.top, to: .bottom, of: yearLabel)
        genreLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        favouriteButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
        favouriteButton.autoPinEdge(.top, to: .bottom, of: genreLabel, withOffset: 16)
        favouriteButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        overviewLabel.autoSetDimension(.height, toSize: 31)
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        overviewLabel.autoPinEdge(.top, to: .bottom, of: myImageView, withOffset: 22)

        overviewTextView.autoSetDimension(.height, toSize: 64)
        overviewTextView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        overviewTextView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        overviewTextView.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 8.38)
        
        collectionView.autoSetDimension(.height, toSize: 105)
        collectionView.autoPinEdge(.top, to: .bottom, of: overviewTextView, withOffset: 27.62)
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        
        flowLayout.scrollDirection = .vertical
        let spacing:CGFloat = 16
        flowLayout.minimumInteritemSpacing = CGFloat(spacing)
        flowLayout.minimumLineSpacing = CGFloat(spacing)
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func formatTime(minutes: Int) -> String {
        let hours = minutes / 60
        let minute = minutes % 60
        return String(format: "%2dh %2dm", hours,minute)
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        details?.crewMembers.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
        let data = details?.crewMembers[indexPath.item]
        cell.titleLabel.text = data?.name
        cell.subtitleLabel.text = data?.role
        return cell
    }
}
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let screenWidth = collectionView.bounds.width
        let cellWidth = (screenWidth - 4 * spacing) / 3
        let cellHeigth: CGFloat = 40
        return CGSize(width: cellWidth, height: cellHeigth)
    }
}
