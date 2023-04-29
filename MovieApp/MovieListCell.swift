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

class MovieListCell: UICollectionViewCell {
    var image = UIImageView()
    var title = UILabel()
    var summary = UILabel()
    var shadowView: UIView!
    var roundedView: UIView!
    let details = MovieUseCase()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayoutForViwes()
    }
    
    func createViews() {
        shadowView = {
            let view = UIView()
            layer.masksToBounds = false
            view.backgroundColor = .clear
            view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowRadius = 20
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            return view
        }()
        roundedView = {
            let view = UIView()
            view.backgroundColor = .white
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            return view
        }()
        contentView.addSubview(shadowView)
        shadowView.addSubview(roundedView)
        roundedView.addSubview(image)
        roundedView.addSubview(title)
        roundedView.addSubview(summary)
       
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.autoPinEdgesToSuperviewEdges()
        
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.autoPinEdgesToSuperviewEdges()
    }
    
    func styleViews() {
        self.backgroundColor = .white
        title.textColor = .black
        title.font = .boldSystemFont(ofSize: 14)
        
        summary.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        summary.font = .systemFont(ofSize: 12)
        summary.numberOfLines = 3
    }
    
    func defineLayoutForViwes() {
        image.autoSetDimensions(to: CGSize(width: 97, height: 142))
        image.autoPinEdge(toSuperviewEdge: .leading)
        image.autoPinEdge(toSuperviewEdge: .top)
      
        title.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        title.autoPinEdge(toSuperviewEdge: .leading, withInset: 113)
        title.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        title.autoPinEdge(toSuperviewEdge: .bottom, withInset: 110)
        
        summary.autoPinEdge(toSuperviewEdge: .bottom, withInset: 32)
        summary.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
        summary.autoPinEdge(toSuperviewEdge: .leading, withInset: 113)
        summary.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
    }

    func configureCell(movie: MovieModel) {
        title.text = movie.name
        summary.text = movie.summary
        
        if let posterUrl = URL(string: movie.imageUrl) {
            image.sd_setImage(with: posterUrl, placeholderImage: UIImage(systemName: "photo")
            , completed: {[weak self] (image,error, cacheType, imageURL) in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    print(movie.id)
                } else {
                    self?.image.image = image
                }
            })
        }
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

