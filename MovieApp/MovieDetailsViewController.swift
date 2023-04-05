//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 30.03.2023..
//

import Foundation
import PureLayout
import MovieAppData

class MovieDetailsViewController : UIViewController, UICollectionViewDelegate {
    private var myImageView: UIImageView!
    private var ratingLabel: UILabel!
    private var userScoreLabel: UILabel!
    private var nameLabel: UILabel!
    private var yearLabel: UILabel!
    private var genreLabel: UILabel!
    private var favouriteButton: UIButton!
    private var overviewLabel: UILabel!
    private var overviewTextView: UITextView!
    let details = MovieUseCase().getDetails(id: 111161)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(details)
        buildView()
        collection()
    }
    
    func createViews() {
        myImageView = UIImageView()
        view.addSubview(myImageView)
        
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
        view.addSubview(overviewLabel)
        
        overviewTextView = UITextView()
        view.addSubview(overviewTextView)
    }
    
    func styleViews() {
        guard let url = details?.imageUrl else { return }
        myImageView.loadFrom(URLAddress: url)
        myImageView.autoSetDimension(.height, toSize: 327)
        
        ratingLabel.autoSetDimensions(to: CGSize(width: 22, height: 19))
        ratingLabel.textColor = .white
        let stringText = String(Double(details?.rating ?? 0.0))
        ratingLabel.text = stringText
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        userScoreLabel.autoSetDimensions(to: CGSize(width: 72, height: 17))
        userScoreLabel.textColor = .white
        userScoreLabel.text = "User score"
        userScoreLabel.font = UIFont.systemFont(ofSize: 12)
        
        nameLabel.autoSetDimensions(to: CGSize(width: 350, height: 34))
        nameLabel.textColor = .white
        nameLabel.text = details?.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
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
        
        genreLabel.autoSetDimensions(to: CGSize(width: 258, height: 20))
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
        genreLabel.font = UIFont.systemFont(ofSize: 12)
        
        favouriteButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
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
        overviewLabel.autoSetDimensions(to: CGSize(width: 350, height: 31))
        overviewLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        overviewTextView.textColor = .black
        overviewTextView.text = details?.summary
        overviewTextView.autoSetDimensions(to: CGSize(width: 358, height: 64))
        overviewTextView.font = UIFont.systemFont(ofSize: 14)
        overviewTextView.isEditable = false
    }
    
    func defineLayoutForViews() {
        myImageView.autoPinEdge(toSuperviewEdge: .leading)
        myImageView.autoPinEdge(toSuperviewEdge: .trailing)
        myImageView.autoPinEdge(toSuperviewEdge: .top)
        
        ratingLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        ratingLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 134)
        
        userScoreLabel.autoPinEdge(.leading, to: .trailing, of: ratingLabel, withOffset: 8)
        userScoreLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 135)
        
        nameLabel.autoPinEdge(.top, to: .bottom, of: userScoreLabel, withOffset: 17)
        nameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        yearLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16)
        yearLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        genreLabel.autoPinEdge(.top, to: .bottom, of: yearLabel)
        genreLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        favouriteButton.autoPinEdge(.top, to: .bottom, of: genreLabel, withOffset: 16)
        favouriteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        overviewLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        overviewLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 349)
        
        overviewTextView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        overviewTextView.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 8.38)
        
        
    }

    func buildView() {
        view.backgroundColor = .white
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func formatTime(minutes: Int) -> String {
        let hours = minutes / 60
        let minute = minutes % 60
        return String(format: "%2dh %2dm", hours,minute)
    }
    
    func collection () {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout )
        view.addSubview(collectionView)
        
        let spacing:CGFloat = 16
        flowlayout.minimumInteritemSpacing = CGFloat(spacing)
        flowlayout.minimumLineSpacing = CGFloat(spacing)
        collectionView.autoSetDimension(.height, toSize: 104)
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.autoPinEdge(toSuperviewEdge: .top, withInset: 480)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
    }
}


