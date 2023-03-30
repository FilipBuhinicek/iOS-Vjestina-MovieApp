//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 30.03.2023..
//

import Foundation
import PureLayout
import MovieAppData


class MovieDetailsViewController : ViewController, UICollectionViewDelegate {
    private var myImageView: UIImageView!
    private var ratingLabel: UILabel!
    private var userScoreLabel: UILabel!
    private var nameLabel: UILabel!
    private var yearLabel: UILabel!
    private var genreLabel: UILabel!
    private var favouriteButton: UIButton!
    private var overviewLabel: UILabel!
    private var overviewText:UITextView!
    let details = MovieUseCase().getDetails(id: 111161)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(details)
        buildView()
        collection()
    }
    
    func imageFunc(){
        myImageView = UIImageView()
        view.addSubview(myImageView)
        
        guard let url = details?.imageUrl else { return }
        myImageView.loadFrom(URLAddress: url)
        myImageView.autoPinEdge(toSuperviewEdge: .leading)
        myImageView.autoPinEdge(toSuperviewEdge: .trailing)
        myImageView.autoPinEdge(toSuperviewEdge: .top)
        myImageView.autoSetDimension(.height, toSize: 327)

    }
    
    func rating(){
        ratingLabel = UILabel()
        myImageView.addSubview(ratingLabel)
        
        ratingLabel.autoSetDimensions(to: CGSize(width: 22, height: 19))
        ratingLabel.textColor = .white
        let stringText = String(Double(details?.rating ?? 0.0))
        ratingLabel.text = stringText
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 14)
        ratingLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        ratingLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 134)
    }
    
    func userScore(){
        userScoreLabel = UILabel()
        myImageView.addSubview(userScoreLabel)
        
        userScoreLabel.autoSetDimensions(to: CGSize(width: 72, height: 17))
        userScoreLabel.textColor = .white
        userScoreLabel.text = "User score"
        userScoreLabel.font = UIFont.systemFont(ofSize: 12)
        userScoreLabel.autoPinEdge(.leading, to: .trailing, of: ratingLabel, withOffset: 8)
        userScoreLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 135)
    }
    
    func name(){
        nameLabel = UILabel()
        myImageView.addSubview(nameLabel)
        
        nameLabel.autoSetDimensions(to: CGSize(width: 350, height: 34))
        nameLabel.textColor = .white
        nameLabel.text = details?.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.autoPinEdge(.top, to: .bottom, of: userScoreLabel, withOffset: 17)
        nameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
    }
    
    func year() {
        yearLabel = UILabel()
        myImageView.addSubview(yearLabel)
        
        yearLabel.autoSetDimensions(to: CGSize(width: 105, height: 20))
        yearLabel.textColor = .white
        guard let stringDatum = details?.releaseDate else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: stringDatum) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let formattedDate = dateFormatter.string(from: date)
            yearLabel.text = formattedDate + " (US)"
        }
        
        yearLabel.font = UIFont.systemFont(ofSize: 12)
        
        yearLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16)
        yearLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
    }
    
    func genre(){
        genreLabel = UILabel()
        myImageView.addSubview(genreLabel)
        
        genreLabel.autoSetDimensions(to: CGSize(width: 258, height: 20))
        genreLabel.textColor = .white
        var string = ""
        let velicina: Int = details?.categories.count ?? 0
        for i in 0..<velicina {
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
        let trajanje = formatTime(minutes: details?.duration ?? 0)
        string = string.trimmingCharacters(in: [" ", ","])
        string.append(" ")
        string.append(trajanje)
        
        genreLabel.text = string
        genreLabel.font = UIFont.systemFont(ofSize: 12)
        
        genreLabel.autoPinEdge(.top, to: .bottom, of: yearLabel)
        genreLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)

    }
    
    func favourite() {
        favouriteButton = UIButton()
        myImageView.addSubview(favouriteButton)
        
        favouriteButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
        favouriteButton.alpha = 0.6
        favouriteButton.layer.backgroundColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1).cgColor
        favouriteButton.layer.cornerRadius = 16
        
        let image = UIImage(systemName: "star")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 9, y: 10, width: 14, height: 13)
        imageView.tintColor = .white
        
        favouriteButton.addSubview(imageView)
        
        favouriteButton.autoPinEdge(.top, to: .bottom, of: genreLabel, withOffset: 16)
        favouriteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
    }
    
    func overview () {
        overviewLabel = UILabel()
        view.addSubview(overviewLabel)
        
        overviewLabel.textColor = .black
        overviewLabel.text = "Overview"
        overviewLabel.autoSetDimensions(to: CGSize(width: 350, height: 31))
        overviewLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        overviewLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        overviewLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 349)
    }
    
    func overviewScroll() {
        overviewText = UITextView()
        view.addSubview(overviewText)
        
        overviewText.textColor = .black
        overviewText.text = details?.summary
        overviewText.autoSetDimensions(to: CGSize(width: 358, height: 64))
        overviewText.font = UIFont.systemFont(ofSize: 14)
        
        overviewText.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        overviewText.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 8.38)
        overviewText.isEditable = false
        
    }
    func buildView(){
        view.backgroundColor = .white
        imageFunc()
        rating()
        userScore()
        name()
        year()
        genre()
        favourite()
        overview()
        overviewScroll()
    }
    
    func formatTime(minutes: Int) -> String {
        let sati = minutes / 60
        let min = minutes % 60
        return String(format: "%2dh %2dm", sati,min)
    }
    
    func collection () {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200),
        collectionViewLayout: flowlayout)
        view.addSubview(collectionView)
        
        let spacing = 16
        let itemWidth = (Int(collectionView.bounds.width) - 4 * spacing)/3
        flowlayout.itemSize = CGSize(width: itemWidth, height: 40)
        flowlayout.minimumInteritemSpacing = CGFloat(spacing)
        flowlayout.minimumLineSpacing = CGFloat(spacing)
        
        collectionView.autoPinEdge(toSuperviewEdge: .top, withInset: 480)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details?.crewMembers.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
        let data = details?.crewMembers[indexPath.item]
        cell.titleLabel.text = data?.name
        cell.subtitleLabel.text = data?.role
        return cell
    }
}
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 109, height: 40)
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
    
}